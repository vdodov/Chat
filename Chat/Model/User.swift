//
//  User.swift
//  Chat
//
//  Created by 차수연 on 2020/05/10.
//  Copyright © 2020 차수연. All rights reserved.
//

import Foundation

struct User {
  let uid: String
  let profileImageUrl: String
  let username: String
  let fullname: String
  let email: String
  
  init(dictionary: [String: Any]) {
    self.uid = dictionary["uid"] as? String ?? ""
    self.profileImageUrl = dictionary["profileImageUrl"] as? String ?? ""
    self.username = dictionary["username"] as? String ?? ""
    self.fullname = dictionary["fullname"] as? String ?? ""
    self.email = dictionary["email"] as? String ?? ""
  }
}
