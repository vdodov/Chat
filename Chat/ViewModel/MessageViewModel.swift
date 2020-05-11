//
//  MessageViewModel.swift
//  Chat
//
//  Created by 차수연 on 2020/05/11.
//  Copyright © 2020 차수연. All rights reserved.
//

import UIKit

struct MessageViewModel {
  
  private let message: Message
  
  var messageBackgroundColor: UIColor {
    return message.isFromCurrentUser ? #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1) : .systemPurple
  }
  
  var messsageTextColor: UIColor {
    return message.isFromCurrentUser ? .black : .white
  }
  
  var rightAnchorActive: Bool {
    return message.isFromCurrentUser
  }
  
  var leftAnchorActive: Bool {
    return !message.isFromCurrentUser
  }
  
  var shouldHideProfileImage: Bool {
    return message.isFromCurrentUser
  }
  
  var profileImageUrl: URL? {
    guard let user = message.user else { return nil }
    return URL(string: user.profileImageUrl)
  }
  
  init(message: Message) {
    self.message = message
  }
  
}
