//
//  ViewController.swift
//  silkrodeTestProject
//
//  Created by Woei-Deng Wang on 2021/11/18.
//

import Foundation
import UIKit

class UsersTableViewController: UITableViewController {
    
    var userViewModels = [UserViewModel]()
    let userCellId = "userCellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        getUsersData()
    }
    
    func getUsersData() {
        for i in 0...1 {
            let userUrlString = "https://api.github.com/users/" + String(i)
            guard let url = URL(string: userUrlString) else { return }
            URLSession.shared.dataTask(with: url) { (data, response, err) in
                guard let data = data else { return }
                do {
                    let user = try JSONDecoder().decode(User.self, from: data)
                    let userViewModel: UserViewModel = UserViewModel(user: user)
                    self.userViewModels.append(userViewModel)
                    print(user)
                    print(self.userViewModels)
                    print("self.userViewModels.count:", self.userViewModels.count)
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                } catch let jsonErr {
                    print("Error serializing:\(jsonErr)")
                }
            }.resume()
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.userViewModels.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: userCellId, for: indexPath) as! UserCell
        let userViewModel = userViewModels[indexPath.row]
        cell.userViewModel = userViewModel
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath)
    
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "UserDetailViewController") as? UserDetailViewController else {
            print("vc for UserdetailViewController is nil.")
            return
        }
        
        let userViewModel = userViewModels[indexPath.row]
        vc.userViewModel = userViewModel
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

