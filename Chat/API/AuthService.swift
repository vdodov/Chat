//
//  AuthService.swift
//  Chat
//
//  Created by 차수연 on 2020/05/09.
//  Copyright © 2020 차수연. All rights reserved.
//

import Firebase
import UIKit

struct RegisterationCredentials {
  let email: String
  let password: String
  let fullname: String
  let username: String
  let profileImage: UIImage
}

struct AuthService {
  static let shared = AuthService()
  
  func logUserIn(withEmail email: String, password: String, completion: AuthDataResultCallback?) {
    Auth.auth().signIn(withEmail: email, password: password, completion: completion)
    
  }
  
  func createUser(credentials: RegisterationCredentials, completion: ((Error?) -> Void)?) {
    guard let imageData = credentials.profileImage.jpegData(compressionQuality: 0.3) else { return }
    
    let fileName = NSUUID().uuidString
    let ref = Storage.storage().reference(withPath: "/profile_images/\(fileName)")
    
    ref.putData(imageData, metadata: nil) { (meta, error) in //1.이미지를 저장
      if let error = error {
        print("DEBUG: Failed to upload image with error \(error.localizedDescription)")
        completion!(error)
        return
      }
      
      ref.downloadURL { (url, error) in //2.이미지url다운
        guard let profileImageUrl = url?.absoluteString else { return }
        
        
        Auth.auth().createUser(withEmail: credentials.email, password: credentials.password) { (result, error) in //3.계정생성
          if let error = error {
            print("DEBUG: Failed to create uesr with error \(error.localizedDescription)")
            completion!(error)
            return
          }
          
          guard let uid = result?.user.uid else { return } //4.파베제공 uid 생성
          
          let data = ["email": credentials.email,
                      "fullname": credentials.fullname,
                      "profileImageUrl": profileImageUrl,
                      "uid": uid,
                      "username": credentials.username] as [String: Any]
          
          Firestore.firestore().collection("users").document(uid).setData(data, completion: completion)
          
//          Firestore.firestore().collection("users").document(uid).setData(data) { (error) in
//            if let error = error {
//              print("DEBUG: Failed to upload uesr data with error \(error.localizedDescription)")
//              return
//            }
//            print("DEBUG: Did create user..")
//            self.dismiss(animated: true, completion: nil)
//          }
          
        }
        
      }
    }
  }
  
}
