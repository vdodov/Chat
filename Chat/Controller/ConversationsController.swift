//
//  ConversationsController.swift
//  Chat
//
//  Created by 차수연 on 2020/05/07.
//  Copyright © 2020 차수연. All rights reserved.
//

import UIKit
import Firebase

private let reuseIdentifier = "ConverstationCell"

class ConversationsController: UIViewController {
  
  // MARK: - Properties
  
  private let tableView = UITableView()
  private var conversations = [Conversation]()
  
  private let newMessageButton: UIButton = {
    let button = UIButton(type: .system)
    button.setImage(UIImage(systemName: "plus"), for: .normal)
    button.backgroundColor = .systemPurple
    button.tintColor = .white
    button.imageView?.setDimensions(height: 24, width: 24)
    button.addTarget(self, action: #selector(showNewMessageController), for: .touchUpInside)
    return button
  }()
  
  // MARK: - LifeCycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configureUI()
    authenticateUser()
    fetchConversations()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    configureNavigationBar(withTitle: "Messages", prefersLargeTitles: true)
  }
  
  // MARK: - Selectors
  
  @objc func showProfile() {
    logout()
  }
  
  @objc func showNewMessageController() {
    let controller = NewMessageController()
    controller.delegate = self
    let nav = UINavigationController(rootViewController: controller)
    nav.modalPresentationStyle = .fullScreen
    present(nav, animated: true, completion: nil)
  }
  
  // MARK: - API
  
  func fetchConversations() {
    Service.fetchConversations { conversations in
      self.conversations = conversations
      self.tableView.reloadData()
    }
  }
  
  func authenticateUser() {
    if Auth.auth().currentUser?.uid == nil {
      print("DEBUG: User is not logged in. Present login screan here..")
      presentLoginScreen()
    } else {
      print("DEBUG: User id is \(Auth.auth().currentUser?.uid)")
    }
  }
  
  func logout() {
    do {
      try Auth.auth().signOut()
      presentLoginScreen()
    } catch {
      print("DEBUG: Error signing out..")
    }
  }
  
  // MARK: - Helpers
  
  func presentLoginScreen() {
    DispatchQueue.main.async {
      let controller = LoginController()
      let nav = UINavigationController(rootViewController: controller)
      nav.modalPresentationStyle = .fullScreen
      self.present(nav, animated: true, completion: nil)
    }
  }
  
  func configureUI() {
    view.backgroundColor = .white
    
    configureTableView()
    
    let image = UIImage(systemName: "person.circle.fill")
    navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(showProfile))
  }
  
  func configureTableView() {
    tableView.backgroundColor = .white
    tableView.rowHeight = 80
    tableView.register(ConversationCell.self, forCellReuseIdentifier: reuseIdentifier)
    tableView.tableFooterView = UIView()
    tableView.delegate = self
    tableView.dataSource = self
    
    view.addSubview(tableView)
    tableView.frame = view.frame
    
    view.addSubview(newMessageButton)
    newMessageButton.setDimensions(height: 56, width: 56)
    newMessageButton.layer.cornerRadius = 56 / 2
    newMessageButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor,
                            paddingBottom: 16, paddingRight: 24)
  }
  
  func showChatController(forUser user: User) {
    let controller = ChatController(user: user)
    navigationController?.pushViewController(controller, animated: true)
  }
  
  
  
}
// MARK: - UITableViewDataSource

extension ConversationsController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    print("DEBUG: ConversationController tableview count \(conversations.count)")
    return conversations.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! ConversationCell
    cell.conversation = conversations[indexPath.row]
    return cell
  }
  
}

// MARK: - UITableViewDelegate

extension ConversationsController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let user = conversations[indexPath.row].user
    showChatController(forUser: user)
    
  }
}

// MARK: - NewMessageControllerDelegate

extension ConversationsController: NewMessageControllerDelegate {
  func controller(_ controller: NewMessageController, wantsToStartChatWith user: User) {
    //    print("DEBUG: User in converstation controller is \(user.username)")
    controller.dismiss(animated: true, completion: nil)
    showChatController(forUser: user)
  }
}

