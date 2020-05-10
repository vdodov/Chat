//
//  ConversationsController.swift
//  Chat
//
//  Created by 차수연 on 2020/05/07.
//  Copyright © 2020 차수연. All rights reserved.
//

import UIKit
import Firebase

private let reuseIdentifier = "ConverstationCell"

class ConversationsController: UIViewController {
  
  // MARK: - Properties
  
  private let tableView = UITableView()
  
  private let newMessageButton: UIButton = {
    let button = UIButton(type: .system)
    button.setImage(UIImage(systemName: "plus"), for: .normal)
    button.backgroundColor = .systemPurple
    button.tintColor = .white
    button.imageView?.setDimensions(height: 24, width: 24)
    button.addTarget(self, action: #selector(showNewMessageController), for: .touchUpInside)
    return button
  }()
  
  // MARK: - LifeCycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configureUI()
    authenticateUser()
  }
  
  // MARK: - Selectors
  
  @objc func showProfile() {
    logout()
  }
  
  @objc func showNewMessageController() {
    let controller = NewMessageController()
    let nav = UINavigationController(rootViewController: controller)
    nav.modalPresentationStyle = .fullScreen
    present(nav, animated: true, completion: nil)
  }
  
  // MARK: - API
  
  func authenticateUser() {
    if Auth.auth().currentUser?.uid == nil {
      print("DEBUG: User is not logged in. Present login screan here..")
      presentLoginScreen()
    } else {
      print("DEBUG: User id is \(Auth.auth().currentUser?.uid)")
    }
  }
  
  func logout() {
    do {
      try Auth.auth().signOut()
      presentLoginScreen()
    } catch {
      print("DEBUG: Error signing out..")
    }
  }
  
  // MARK: - Helpers
  
  func presentLoginScreen() {
    DispatchQueue.main.async {
      let controller = LoginController()
      let nav = UINavigationController(rootViewController: controller)
      nav.modalPresentationStyle = .fullScreen
      self.present(nav, animated: true, completion: nil)
    }
  }
  
  func configureUI() {
    view.backgroundColor = .white
    
    configureNavigationBar(withTitle: "Messages", prefersLargeTitles: true)
    configureTableView()
    
    let image = UIImage(systemName: "person.circle.fill")
    navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(showProfile))
  }
  
  func configureTableView() {
    tableView.backgroundColor = .white
    tableView.rowHeight = 80
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
    tableView.tableFooterView = UIView()
    tableView.delegate = self
    tableView.dataSource = self
    
    view.addSubview(tableView)
    tableView.frame = view.frame
    
    view.addSubview(newMessageButton)
    newMessageButton.setDimensions(height: 56, width: 56)
    newMessageButton.layer.cornerRadius = 56 / 2
    newMessageButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor,
                            paddingBottom: 16, paddingRight: 24)
  }
  
  
  
}

extension ConversationsController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 2
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
    cell.textLabel?.text = "Test Cell"
    return cell
  }
  
}

extension ConversationsController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    print("DEBUG: IndexPath is \(indexPath.row)")
  }
}
