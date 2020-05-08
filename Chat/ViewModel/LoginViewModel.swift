//
//  LoginViewModel.swift
//  Chat
//
//  Created by 차수연 on 2020/05/08.
//  Copyright © 2020 차수연. All rights reserved.
//

import Foundation

protocol AuthenticationProtocol {
  var formIsValid: Bool { get }
}

struct LoginViewModel: AuthenticationProtocol {
  var email: String?
  var password: String?
  
  var formIsValid: Bool {
    return email?.isEmpty == false
      && password?.isEmpty == false
  }
}
