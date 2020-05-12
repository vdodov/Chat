//
//  ChatController.swift
//  Chat
//
//  Created by 차수연 on 2020/05/11.
//  Copyright © 2020 차수연. All rights reserved.
//

import UIKit

private let reuseIdentifier = "MessageCell"

class ChatController: UICollectionViewController {
  
  // MARK: - Properties
  
  private let user: User
  private var messages = [Message]()
  var fromCurrentUser = false
  
  private lazy var customInputView: CustomInputAccessoryView = {
    let width = view.frame.width
    let view = CustomInputAccessoryView(frame: CGRect(x: 0, y: 0, width: width, height: 50))
    view.delegate = self
    return view
  }()
  
  // MARK: - LifeCycle
  
  init(user: User) {
    self.user = user
    super.init(collectionViewLayout: UICollectionViewFlowLayout())
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configureUI()
    fetchMessages()
  }
  
  override var inputAccessoryView: UIView? {
    get { customInputView }
  }
  
  override var canBecomeFirstResponder: Bool {
    return true
  }
  
  // MARK: - API
  
  func fetchMessages() {
    showLoader(true)
    Service.fetchMessages(forUser: user) { messages in
      self.showLoader(false)
      
      self.messages = messages
      self.collectionView.reloadData()
      
      self.collectionView.scrollToItem(at: [0, self.messages.count - 1],
                                       at: .bottom, animated: true)
      
    }
  }
  
  // MARK: - Helper Functions
  
  func configureUI() {
    collectionView.backgroundColor = .white
    configureNavigationBar(withTitle: user.username, prefersLargeTitles: false)
    
    collectionView.register(MessageCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    collectionView.alwaysBounceVertical = true
    collectionView.keyboardDismissMode = .interactive
  }
  
  
}
// MARK: -UICollectionViewDataSource

extension ChatController {
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return messages.count
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MessageCell
    cell.message = messages[indexPath.row]
    cell.message?.user = user
    return cell
  }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension ChatController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return .init(top: 16, left: 0, bottom: 16, right: 0)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    
    let frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 50)
    let estimatedSizeCell = MessageCell(frame: frame)
    estimatedSizeCell.message = messages[indexPath.row]
    estimatedSizeCell.layoutIfNeeded()
    
    let targetSize = CGSize(width: view.frame.width, height: 1000)
    let estimatedSize = estimatedSizeCell.systemLayoutSizeFitting(targetSize)
    
    return .init(width: view.frame.width, height: estimatedSize.height)
  }
}

// MARK: - CustomInputAccessoryViewDelegate

extension ChatController: CustomInputAccessoryViewDelegate {
  func inputView(_ inputView: CustomInputAccessoryView, wantsToSend message: String) {
//    fromCurrentUser.toggle()
//
//    let message = Message(text: message, isFromCurrentUser: fromCurrentUser)
//    messages.append(message)
//    collectionView.reloadData()
    Service.uploadMessage(message, to: user) { (error) in
      if let error = error {
        print("DEBUG: Failed to upload message with error \(error.localizedDescription)")
        return
      }
      inputView.clearMessageText()
    }
    
    
  }
  
  
}
