//
//  ProfileCell.swift
//  Chat
//
//  Created by 차수연 on 2020/05/12.
//  Copyright © 2020 차수연. All rights reserved.
//

import UIKit

class ProfileCell: UITableViewCell {
  
  // MARK: - Properties
  
  var viewMdoel: ProfileViewModel? {
    didSet { configure() }
  }
  
  private lazy var iconView: UIView = {
    let view = UIView()
    
    view.addSubview(iconImage)
    iconImage.centerX(inView: view)
    iconImage.centerY(inView: view)
    
    view.backgroundColor = .systemPurple
    view.setDimensions(height: 40, width: 40)
    view.layer.cornerRadius = 40 / 2
    return view
  }()
  
  private let iconImage: UIImageView = {
    let iv = UIImageView()
    iv.contentMode = .scaleAspectFill
    iv.clipsToBounds = true
    iv.setDimensions(height: 28, width: 28)
    iv.tintColor = .white
    return iv
  }()
  
  private let titleLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 16)
    return label
  }()
  
  // MARK: - LifeCycle
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    let stack = UIStackView(arrangedSubviews: [iconView, titleLabel])
    stack.axis = .horizontal
    stack.spacing = 8
    
    addSubview(stack)
    stack.centerY(inView: self, leftAnchor: leftAnchor, paddingLeft: 12)
  }
  
  // MARK: - Helper Functions
  
  func configure() {
    guard let viewModel = viewMdoel else { return }
    
    iconImage.image = UIImage(systemName: viewModel.iconImageName)
    titleLabel.text = viewModel.description
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

}
