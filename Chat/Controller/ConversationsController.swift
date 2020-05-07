//
//  ConversationsController.swift
//  Chat
//
//  Created by 차수연 on 2020/05/07.
//  Copyright © 2020 차수연. All rights reserved.
//

import UIKit

private let reuseIdentifier = "ConverstationCell"

class ConversationsController: UIViewController {
  
  // MARK: - Properties
  
  private let tableView = UITableView()
  
  // MARK: - LifeCycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configureUI()
  }
  
  // MARK: - Selectors
  @objc func showProfile() {
    print("DEBUG: 123")
  }
  
  // MARK: - Helpers
  
  func configureUI() {
    view.backgroundColor = .white
    
    configureNavigationBar()
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
  }
  
  func configureNavigationBar() {
    let apperane = UINavigationBarAppearance()
    apperane.configureWithOpaqueBackground()
    apperane.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
    apperane.backgroundColor = .systemPurple
    
    navigationController?.navigationBar.standardAppearance = apperane
    navigationController?.navigationBar.compactAppearance = apperane
    navigationController?.navigationBar.scrollEdgeAppearance = apperane
    
    navigationController?.navigationBar.prefersLargeTitles = true
    navigationItem.title = "Messages"
    navigationController?.navigationBar.tintColor = .white
    navigationController?.navigationBar.isTranslucent = true
    
    navigationController?.navigationBar.overrideUserInterfaceStyle = .dark
    
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
