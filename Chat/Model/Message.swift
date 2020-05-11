//
//  Message.swift
//  Chat
//
//  Created by 차수연 on 2020/05/11.
//  Copyright © 2020 차수연. All rights reserved.
//

import Firebase

struct Message {
  let text: String
  let toId: String
  let fromId: String
  var timestamp: Timestamp!
  var user: User?
  
  let isFromCurrentUser: Bool
  
  init(dictionary: [String: Any]) {
    self.text = dictionary["text"] as? String ?? ""
    self.toId = dictionary["toId"] as? String ?? ""
    self.fromId = dictionary["fromId"] as? String ?? ""
    self.timestamp = dictionary["timestamp"] as? Timestamp ?? Timestamp(date: Date())
    
    self.isFromCurrentUser = fromId == Auth.auth().currentUser?.uid
  }
}

struct Conversation {
  let user: User
  let message: Message 
}
