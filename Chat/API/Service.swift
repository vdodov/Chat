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
    COLLECTION_USERS.getDocuments { (snapshot, error) in
      snapshot?.documents.forEach({ document in
//        print("DEBUG: \(document.data())")
        
        let dictionary = document.data()
        let user = User(dictionary: dictionary)
        
        users.append(user)
        completion(users)
      })
    }
  }
  
  static func fetchUser(withUid uid: String, completion: @escaping(User) -> Void) {
    COLLECTION_USERS.document(uid).getDocument { (snapshot, error) in
      guard let dictionary = snapshot?.data() else { return }
      
      let user = User(dictionary: dictionary)
      completion(user)
      
    }
  }
  
  static func fetchConversations(completion: @escaping([Conversation]) -> Void) {
    var conversations = [Conversation]()
    guard let uid = Auth.auth().currentUser?.uid else { return }
    
    let query = COLLECTION_MESSAGE.document(uid).collection("recent-messages").order(by: "timestamp")
    
    query.addSnapshotListener { (snapshot, error) in
      snapshot?.documentChanges.forEach({ change in
        let dictionary = change.document.data()
        let message = Message(dictionary: dictionary)
        
        self.fetchUser(withUid: message.toId) { user in
          let conversation = Conversation(user: user, message: message)
          conversations.append(conversation)
          completion(conversations)
        }
        
      })
    }
  }
  
  static func fetchMessages(forUser user: User, completion: @escaping([Message]) -> Void) {
    var messages = [Message]()
    guard let currentUid = Auth.auth().currentUser?.uid else { return }
    
    let query = COLLECTION_MESSAGE.document(currentUid).collection(user.uid).order(by: "timestamp")
    
    query.addSnapshotListener { (snapshot, error) in
      snapshot?.documentChanges.forEach({ change in
        if change.type == .added {
          let dictionary = change.document.data()
          messages.append(Message(dictionary: dictionary))
          completion(messages)
        }
      })
    }
  }
  
  static func uploadMessage(_ message: String, to user: User, completion: ((Error?) -> Void)?) {
    guard let currentUid = Auth.auth().currentUser?.uid else { return }
    
    let data = ["text": message,
                "fromId": currentUid,
                "toId": user.uid,
                "timestamp": Timestamp(date: Date())] as [String : Any]
    
    COLLECTION_MESSAGE.document(currentUid).collection(user.uid).addDocument(data: data) { _ in
      COLLECTION_MESSAGE.document(user.uid).collection(currentUid).addDocument(data: data, completion: completion)
      
      
      COLLECTION_MESSAGE.document(currentUid).collection("recent-messages").document(user.uid).setData(data, completion: completion)
      
      COLLECTION_MESSAGE.document(user.uid).collection("recent-messages").document(currentUid).setData(data, completion: completion)
    }
  }
  
  
}
