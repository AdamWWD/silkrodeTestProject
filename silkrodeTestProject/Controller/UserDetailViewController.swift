//
//  UserDetailViewController.swift
//  silkrodeTestProject
//
//  Created by Woei-Deng Wang on 2021/11/22.
//

import UIKit

class UserDetailViewController: UIViewController {
    @IBOutlet weak var userAvartarImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userNameLabelForDownView: UILabel!
    @IBOutlet weak var userLocationLabel: UILabel!
    @IBOutlet weak var userBlogLabel: UILabel!
    
    var userViewModel: UserViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showUserDetailData()
    }
    
    func showUserDetailData() {
        userAvartarImage.layer.cornerRadius = 75
        userAvartarImage.clipsToBounds = true
        
        guard let url = URL(string: userViewModel.avatar_url) else { return }
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.userAvartarImage.image = image
                }
            }
        }
        task.resume()
        
        self.userName.text = userViewModel.name
        self.userNameLabelForDownView.text = userViewModel.name
        self.userLocationLabel.text = userViewModel.location
        self.userBlogLabel.text = userViewModel.blog
    }
}
