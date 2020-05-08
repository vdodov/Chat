//
//  InputContainerView.swift
//  Chat
//
//  Created by 차수연 on 2020/05/07.
//  Copyright © 2020 차수연. All rights reserved.
//

import UIKit

class InputContainerView: UIView {
  
  init(image: UIImage, textField: UITextField) {
    super.init(frame: .zero)
    
    setHeight(height: 50)
    
    let iv = UIImageView()
    iv.image = image
    iv.tintColor = .white
    iv.alpha = 0.87
    
    addSubview(iv)
    iv.centerY(inView: self)
    iv.anchor(left: self.leftAnchor, paddingLeft: 8)
    iv.setDimensions(height: 24, width: 24)
    
    addSubview(textField)
    textField.centerY(inView: self)
    textField.anchor(left: iv.rightAnchor, bottom: self.bottomAnchor, right: self.rightAnchor,
                          paddingLeft: 8, paddingBottom: -8)
    
    let dividerView = UIView()
    dividerView.backgroundColor = .white
    addSubview(dividerView)
    dividerView.anchor(left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingLeft: 8, height: 0.75)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
