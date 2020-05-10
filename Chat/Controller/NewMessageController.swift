//
//  NewMessageController.swift
//  Chat
//
//  Created by 차수연 on 2020/05/10.
//  Copyright © 2020 차수연. All rights reserved.
//

import UIKit

private let reuseIdentifier = "UserCell"

class NewMessageController: UITableViewController {
  
  // MARK: - Properties
  
  private var users = [User]()
  
  // MARK: - LifeCycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configureUI()
    fetchUsers()
  }
  
  // MARK: - Selectors
  
  @objc func handleDismissal() {
    dismiss(animated: true, completion: nil)
  }
  
  // MARK: - API
  
  func fetchUsers() {
    Service.fetchUsers { (users) in
      self.users = users
      print("DEBUG: User in new message controller \(users)")
      self.tableView.reloadData()
    }
  }
  
  // MARK: - Helper Functions
  func configureUI() {
    configureNavigationBar(withTitle: "New Message", prefersLargeTitles: false)
    navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(handleDismissal))
    
    tableView.tableFooterView = UIView()
    tableView.register(UserCell.self, forCellReuseIdentifier: reuseIdentifier)
    tableView.rowHeight = 80
  }
  
}

// MARK: - UITableViewDataSource

extension NewMessageController {
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    print("DEBUG: User count is \(users.count)")
    return users.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! UserCell
    cell.user = users[indexPath.row]
    return cell
  }
}
