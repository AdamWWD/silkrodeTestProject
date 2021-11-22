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
            guard let mine = mine else {
                print("mine data is nil")
                return
            }
            
            print(mine)
            self.mineAvatarImage.layer.cornerRadius = 50
            self.mineAvatarImage.clipsToBounds = true
            
            guard let url = URL(string: mine.avatar_url ?? "") else { return }
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let data = data, let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.mineAvatarImage.image = image
                    }
                }
            }
            task.resume()
            
            self.mineNameLabel.text = mine.name
            self.loginLabel.text = mine.login
            
            let followers = mine.followers ?? 0
            let following = mine.following ?? 0

            self.followersLabel.text = "\(String(describing: followers)) followers"+"・"
            self.followingLabel.text = "\(String(describing: following)) following"+"・"
            
            self.emailLabel.text = mine.email
            
            
            
        }
    }
}
