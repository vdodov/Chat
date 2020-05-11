//
//  CustomInputAccessoryView.swift
//  Chat
//
//  Created by 차수연 on 2020/05/11.
//  Copyright © 2020 차수연. All rights reserved.
//

import UIKit

protocol CustomInputAccessoryViewDelegate: class {
  func inputView(_ inputView: CustomInputAccessoryView, wantsToSend message: String)
}

class CustomInputAccessoryView: UIView {
  
  // MARK: - Properties
  
  weak var delegate: CustomInputAccessoryViewDelegate?
  
  let messageInputTextView: UITextView = {
    let tv = UITextView()
    tv.font = UIFont.systemFont(ofSize: 16)
    tv.isScrollEnabled = false
    return tv
  }()
  
  private let sendButton: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle("Send", for: .normal)
    button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
    button.setTitleColor(.systemPurple, for: .normal)
    button.addTarget(self, action: #selector(handleSendMessage), for: .touchUpInside)
    return button
  }()
  
  private lazy var placeholderLabel: UILabel = {
    let label = UILabel()
    label.text = "Enter Message"
    label.font = UIFont.systemFont(ofSize: 16)
    label.textColor = .lightGray
    return label
  }()
  
  // MARK: - LifeCycle
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    autoresizingMask = .flexibleHeight
    
    backgroundColor = .white
    
    layer.shadowOpacity = 0.25
    layer.shadowRadius = 10
    layer.shadowOffset = .init(width: 0, height: -8)
    layer.shadowColor = UIColor.lightGray.cgColor
    
    addSubview(sendButton)
    sendButton.anchor(top: topAnchor, right: rightAnchor, paddingTop: 4, paddingRight: 8)
    sendButton.setDimensions(height: 50, width: 50)
    
    addSubview(messageInputTextView)
    messageInputTextView.anchor(top: topAnchor, left: leftAnchor, bottom: safeAreaLayoutGuide.bottomAnchor, right: sendButton.leftAnchor, paddingTop: 12, paddingLeft: 4, paddingBottom: 8, paddingRight: 8)
    
    addSubview(placeholderLabel)
    placeholderLabel.anchor(left: messageInputTextView.leftAnchor, paddingLeft: 4)
    placeholderLabel.centerY(inView: messageInputTextView)
    
    NotificationCenter.default.addObserver(self, selector: #selector(handleTextInputChange), name: UITextView.textDidChangeNotification, object: nil)
  }
  
  override var intrinsicContentSize: CGSize {
    return .zero
  }
  
  // MARK: - Selectors
  @objc func handleSendMessage() {
    guard let message = messageInputTextView.text else { return }
    delegate?.inputView(self, wantsToSend: message)
  }
  
  @objc func handleTextInputChange() {
    placeholderLabel.isHidden = !self.messageInputTextView.text.isEmpty
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  
}
