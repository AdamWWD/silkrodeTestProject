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
        getUsersData(starIndex:0, endIndex:10)
        setUpSwipe()
    }
    
    func setUpSwipe() {
        let swipeRight = UISwipeGestureRecognizer(target: self, action:  #selector(swiped))
        swipeRight.direction = UISwipeGestureRecognizer.Direction.right
        self.view.addGestureRecognizer(swipeRight)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(swiped))
        swipeLeft.direction = UISwipeGestureRecognizer.Direction.left
        self.view.addGestureRecognizer(swipeLeft)
        // below code create swipe gestures function
    }
    
    @objc func swiped(_ gesture: UISwipeGestureRecognizer) {
        if gesture.direction == .left {
            if (self.tabBarController?.selectedIndex)! < 2
            { // set here  your total tabs
                self.tabBarController?.selectedIndex += 1
            }
        } else if gesture.direction == .right {
            if (self.tabBarController?.selectedIndex)! > 0 {
                self.tabBarController?.selectedIndex -= 1
            }
        }
    }
    
    func getUsersData(starIndex:Int, endIndex:Int) {
        Service.shared.getUsersData(userDataMin: starIndex, userDataMax: endIndex) { arrUserViewModels, err in
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
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        print("show will display:", indexPath.row)
    
        let userViewModelsCount = userViewModels?.count ?? 0
        if indexPath.row  == userViewModelsCount - 1 {
            print( "get new user data")
            getUsersData(starIndex: userViewModelsCount, endIndex: userViewModelsCount + 10)
        }
    }
    
}

