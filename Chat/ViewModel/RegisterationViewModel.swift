//
//  RegisterationViewModel.swift
//  Chat
//
//  Created by 차수연 on 2020/05/08.
//  Copyright © 2020 차수연. All rights reserved.
//

import Foundation

struct RegisterationViewModel: AuthenticationProtocol {
  var email: String?
  var password: String?
  var fullname: String?
  var username: String?
  
  var formIsValid: Bool {
    return email?.isEmpty == false
      && password?.isEmpty == false
      && fullname?.isEmpty == false
      && username?.isEmpty == false
  }
  
}
