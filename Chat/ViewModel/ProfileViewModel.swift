//
//  ProfileViewModel.swift
//  Chat
//
//  Created by 차수연 on 2020/05/12.
//  Copyright © 2020 차수연. All rights reserved.
//

import Foundation

enum ProfileViewModel: Int, CaseIterable {
  case acaaountInfo
  case settings
  
  var description: String {
    switch self {
    case .acaaountInfo: return "Account Info"
    case .settings: return "Settings"
    }
  }
  
  var iconImageName: String {
    switch self {
    case .acaaountInfo: return "person.circle"
    case .settings: return "gear"
    }
  }
}
