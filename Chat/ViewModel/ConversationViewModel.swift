//
//  ConversationViewModel.swift
//  Chat
//
//  Created by 차수연 on 2020/05/11.
//  Copyright © 2020 차수연. All rights reserved.
//

import Foundation

struct ConversationViewModel {
  private let conversation: Conversation
  
  var profileImageUrl: URL? {
    return URL(string: conversation.user.profileImageUrl)
  }
  
  var timestamp: String {
    let date = conversation.message.timestamp.dateValue()
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "hh:mm a"
    return dateFormatter.string(from: date)
    
  }
  
  init(conversation: Conversation) {
    self.conversation = conversation
  }
}
