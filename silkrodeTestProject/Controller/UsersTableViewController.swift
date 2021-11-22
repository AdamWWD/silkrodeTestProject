//
//  ViewController.swift
//  silkrodeTestProject
//
//  Created by Woei-Deng Wang on 2021/11/18.
//

import Foundation
import UIKit

class UsersTableViewController: UITableViewController {
    var userViewModels: [UserViewModel]?
    let userCellId = "userCellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Github"
        getUsersData()
    }
    
    func getUsersData() {
        Service.shared.getUsersData { arrUserViewModels, err in
            if let err = err {
                print("Failed to get user data:", err)
                return
            }
            
            self.userViewModels = arrUserViewModels
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.userViewModels?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: userCellId, for: indexPath) as! UserCell
        let userViewModel = userViewModels?[indexPath.row]
        cell.userViewModel = userViewModel
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "UserDetailViewController") as? UserDetailViewController else {
            print("vc for UserdetailViewController is nil.")
            return
        }
        
        let userViewModel = userViewModels?[indexPath.row]
        vc.userViewModel = userViewModel
        present(vc, animated: true, completion: nil)
    }
}

