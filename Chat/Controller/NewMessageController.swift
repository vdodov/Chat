//
//  NewMessageController.swift
//  Chat
//
//  Created by 차수연 on 2020/05/10.
//  Copyright © 2020 차수연. All rights reserved.
//

import UIKit

private let reuseIdentifier = "UserCell"

protocol NewMessageControllerDelegate: class {
  func controller(_ controller: NewMessageController, wantsToStartChatWith user: User)
}

class NewMessageController: UITableViewController {
  
  // MARK: - Properties
  
  private var users = [User]()
  private var filterUsers = [User]()
  weak var delegate: NewMessageControllerDelegate?
  
  private let searchController = UISearchController(searchResultsController: nil)
  
  private var isSearchMode: Bool {
    return searchController.isActive
      && !searchController.searchBar.text!.isEmpty
  }
  // MARK: - LifeCycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configureUI()
    configureSearchController()
    fetchUsers()
  }
  
  // MARK: - Selectors
  
  @objc func handleDismissal() {
    dismiss(animated: true, completion: nil)
  }
  
  // MARK: - API
  
  func fetchUsers() {
    showLoader(true)
    Service.fetchUsers { (users) in
      self.showLoader(false)
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
  
  func configureSearchController() {
    searchController.searchResultsUpdater = self
    searchController.searchBar.showsCancelButton = false
    navigationItem.searchController = searchController
    searchController.obscuresBackgroundDuringPresentation = false
    searchController.hidesNavigationBarDuringPresentation = false
    searchController.searchBar.placeholder = "Search for a user"
    definesPresentationContext = false
    
    if let textField = searchController.searchBar.value(forKey: "searchField") as? UITextField {
      textField.textColor = .systemPurple
      textField.backgroundColor = .white
    }
  }
  
}

// MARK: - UITableViewDataSource

extension NewMessageController {
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    print("DEBUG: User count is \(users.count)")
    return isSearchMode ? filterUsers.count : users.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! UserCell
    cell.user = isSearchMode ? filterUsers[indexPath.row] : users[indexPath.row]
    return cell
  }
}

// MARK: - UITableViewDelegate

extension NewMessageController {
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//    print("DEBUG: Selected user is \(users[indexPath.row].username)")
    let user = isSearchMode ? filterUsers[indexPath.row] : users[indexPath.row]
    
    delegate?.controller(self, wantsToStartChatWith: user)
  }
}

extension NewMessageController: UISearchResultsUpdating {
  func updateSearchResults(for searchController: UISearchController) {
    guard let searchText = searchController.searchBar.text?.lowercased() else { return }
    
    filterUsers = users.filter({ user -> Bool in
      return user.username.contains(searchText) || user.fullname.contains(searchText)
    })
    
    self.tableView.reloadData()
//    print("DEBUG: Filtered users \(filterUsers)")
  }
}
