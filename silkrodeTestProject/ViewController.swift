//
//  ViewController.swift
//  silkrodeTestProject
//
//  Created by Woei-Deng Wang on 2021/11/18.
//

import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        getUserData()
    }
    
    func getUserData() {
        
        let userUrlString = "https://api.github.com/users/0"
        guard let url = URL(string: userUrlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            guard let data = data else { return }
            do {
                let user = try JSONDecoder().decode(User.self, from: data)
                print(user)
//                let user = try JSONDecoder().decode(User.self, from: data)
                
            } catch let jsonErr {
                print("Error serializing:\(jsonErr)")
            }
        }.resume()
        
        
        
    }


}

