//
//  UserCell.swift
//  silkrodeTestProject
//
//  Created by Woei-Deng Wang on 2021/11/20.
//

import UIKit

class UserCell: UITableViewCell {
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userType: UILabel!
    
    var userViewModel: UserViewModel! {
        didSet {
            guard let url = URL(string: userViewModel.avatar_url) else { return }
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let data = data, let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.avatar.image = image
                    }
                }
            }
            task.resume()
            
            self.userName.text = userViewModel.name
            self.userType.text = userViewModel.type
        }
    }
}
