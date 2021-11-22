//
//  Service.swift
//  silkrodeTestProject
//
//  Created by Woei-Deng Wang on 2021/11/22.
//

import Foundation

class Service:NSObject {
    static let shared = Service()
    
    var userViewModels = [UserViewModel]()
//    var userDataMin = 0
//    var userDataMax = 10
    
    func getUsersData(userDataMin:Int, userDataMax:Int, completion: @escaping ([UserViewModel]?, Error?) -> ()) {
        for i in userDataMin...userDataMax {
            print("i:", i)
            let userUrlString = "https://api.github.com/users/" + String(i)
            guard let url = URL(string: userUrlString) else { return }
            URLSession.shared.dataTask(with: url) { (data, response, err) in
                if let err = err {
                    completion(nil, err)
                    print("Failed to get user data")
                    return
                }

                guard let data = data else { return }
                do {
                    let user = try JSONDecoder().decode(User.self, from: data)
                    print(user)
                    let userViewModel: UserViewModel = UserViewModel(user: user)
                    self.userViewModels.append(userViewModel)
                    print("self.userViewModels.count:", self.userViewModels.count)
                    if self.userViewModels.count >= userDataMax - 1 {
                        DispatchQueue.main.async {
                            completion(self.userViewModels, nil)
                        }
                    }
                } catch let jsonErr {
                    print("Error serializing:\(jsonErr)")
                }
            }.resume()
        }
    }
    
    func getMineData(completion: @escaping (User?, Error?) -> ()) {
        let mineUrlString = "https://api.github.com/users/AdamWWD"
        guard let url = URL(string: mineUrlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            if let err = err {
                completion(nil, err)
                print("Failed to get mine data")
                return
            }
            
            guard let data = data else { return }
            do {
                let mine = try JSONDecoder().decode(User.self, from: data)
                DispatchQueue.main.async {
                    completion(mine, nil)
                }
                
            } catch let jsonErr {
                print("Error serializing:\(jsonErr)")
            }
        }.resume()
    }
    
}
