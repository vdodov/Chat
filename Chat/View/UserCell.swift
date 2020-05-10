//
//  UserCell.swift
//  Chat
//
//  Created by 차수연 on 2020/05/10.
//  Copyright © 2020 차수연. All rights reserved.
//

import UIKit
import SDWebImage

class UserCell: UITableViewCell {
  
  // MARK: - Properties
  
  var user: User? {
    didSet { configure() }
  }
  
  private let profileImageView: UIImageView = {
    let iv = UIImageView()
    iv.backgroundColor = .systemPurple
    iv.contentMode = .scaleAspectFill
    iv.clipsToBounds = true
    return iv
  }()
  
  private let usernameLable: UILabel = {
    let label = UILabel()
    label.font = UIFont.boldSystemFont(ofSize: 14)
    label.text = "username"
    return label
  }()
  
  private let fullnameLable: UILabel = {
    let label = UILabel()
    label.font = UIFont.boldSystemFont(ofSize: 14)
    label.textColor = .lightGray
    label.text = "fullname"
    return label
  }()
  
  // MARK: - LifeCycle
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    addSubview(profileImageView)
    profileImageView.centerY(inView: self, leftAnchor: leftAnchor, paddingLeft: 12)
    profileImageView.setDimensions(height: 56, width: 56)
    profileImageView.layer.cornerRadius = 56 / 2
    
    let stack = UIStackView(arrangedSubviews: [usernameLable, fullnameLable])
    stack.axis = .vertical
    stack.spacing = 2
    
    addSubview(stack)
    stack.centerY(inView: profileImageView, leftAnchor: profileImageView.rightAnchor, paddingLeft: 12)
  }
  
  // MARK: - Helper Functions
  
  func configure() {
    guard let user = user else { return }
    fullnameLable.text = user.fullname
    usernameLable.text = user.username
    
    guard let url = URL(string: user.profileImageUrl) else { return }
    profileImageView.sd_setImage(with: url)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  
}
