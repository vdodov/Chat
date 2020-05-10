//
//  Service.swift
//  Chat
//
//  Created by 차수연 on 2020/05/10.
//  Copyright © 2020 차수연. All rights reserved.
//

import Firebase

struct Service {
  
  static func fetchUsers(completion: @escaping([User]) -> Void) {
    var users = [User]()
    Firestore.firestore().collection("users").getDocuments { (snapshot, error) in
      snapshot?.documents.forEach({ document in
//        print("DEBUG: \(document.data())")
        
        let dictionary = document.data()
        let user = User(dictionary: dictionary)
        
        users.append(user)
        completion(users)
      })
    }
  }
  
  
}
