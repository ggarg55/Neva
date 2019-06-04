//
//  UserListViewController.swift
//  Neva
//
//  Created by Gourav  Garg on 31/05/19.
//  Copyright © 2019 Gourav  Garg. All rights reserved.
//

import UIKit

class UserListViewController: UIViewController {

    @IBOutlet weak var userTableView: UITableView!
    
    let cellIdentifier = "UserTableViewCell"
    var usersList: [UserData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getUsers()
        userTableView.estimatedRowHeight = 300
        userTableView.rowHeight = UITableView.automaticDimension
    }
}

extension UserListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usersList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = userTableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! UserTableViewCell
        cell.confiureCell(data: usersList[indexPath.row])
        return cell
    }
}

//TODO: Handle This in API Manager
extension UserListViewController {
    func getUsers() {
        let service = UserService()
        service.getUserList { [weak self] (list) in
            if let list = list, let users = service.filterList(list) {
                DispatchQueue.main.async {
                    self?.usersList = users
                    self?.userTableView.reloadData()
                }
            }
        }
    }
}
