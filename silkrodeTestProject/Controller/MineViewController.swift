//
//  MineViewController.swift
//  silkrodeTestProject
//
//  Created by Woei-Deng Wang on 2021/11/22.
//

import UIKit

class MineViewController: UIViewController {
    
    
    @IBOutlet weak var mineBackGroundImage: UIImageView!
    @IBOutlet weak var mineAvatarImage: UIImageView!
    @IBOutlet weak var mineNameLabel: UILabel!
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var followersLabel: UILabel!
    @IBOutlet weak var followingLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getMineData()
        self.navigationItem.title = "Github"
    }
    
    func getMineData() {
        
        Service.shared.getMineData { (mine, error) in
            print(mine)
//            self.mineAvartarImage
//            
//            
//            self.mineAvartarImage.image = mine?.avatar_url
        }
        
//        let userUrlString = "https://api.github.com/users/AdamWWD"
//        guard let url = URL(string: userUrlString) else { return }
//        URLSession.shared.dataTask(with: url) { (data, response, err) in
//            guard let data = data else { return }
//            do {
//                let user = try JSONDecoder().decode(User.self, from: data)
//                let userViewModel: UserViewModel = UserViewModel(user: user)
//                self.userViewModels.append(userViewModel)
//                print(user)
//                print(self.userViewModels)
//                print("self.userViewModels.count:", self.userViewModels.count)
//                DispatchQueue.main.async {
//                    self.tableView.reloadData()
//                }
//            } catch let jsonErr {
//                print("Error serializing:\(jsonErr)")
//            }
//        }.resume()
        
        
    }
}
