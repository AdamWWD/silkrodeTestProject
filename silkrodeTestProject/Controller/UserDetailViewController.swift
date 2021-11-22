//
//  UserDetailViewController.swift
//  silkrodeTestProject
//
//  Created by Woei-Deng Wang on 2021/11/22.
//

import UIKit

class UserDetailViewController: UIViewController {
    @IBOutlet weak var userAvatarImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userNameLabelForDownView: UILabel!
    @IBOutlet weak var userLocationLabel: UILabel!
    @IBOutlet weak var userBlogLabel: UILabel!
    @IBOutlet weak var dismissImage: UIImageView!
    
    var userViewModel: UserViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showUserDetailData()
        self.navigationItem.title = ""
        self.navigationController?.navigationBar.tintColor = UIColor.white
        
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(tapDetected))
        self.dismissImage.isUserInteractionEnabled = true
        self.dismissImage.addGestureRecognizer(singleTap)
    }

    //Action
    @objc func tapDetected() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func showUserDetailData() {
        userAvatarImage.layer.cornerRadius = 75
        userAvatarImage.clipsToBounds = true
        
        guard let url = URL(string: userViewModel.avatar_url) else { return }
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.userAvatarImage.image = image
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
