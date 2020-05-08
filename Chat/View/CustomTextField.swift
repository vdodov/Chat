//
//  CustomTextField.swift
//  Chat
//
//  Created by 차수연 on 2020/05/07.
//  Copyright © 2020 차수연. All rights reserved.
//

import UIKit

class CustomTextField: UITextField {
  init(placeholder: String) {
    super.init(frame: .zero)
    
    borderStyle = .none
    font = UIFont.systemFont(ofSize: 16)
    textColor = .white
    keyboardAppearance = .dark
    attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
    
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  
}
