//
//  File.swift
//  silkrodeTestProject
//
//  Created by Woei-Deng Wang on 2021/11/20.
//

import Foundation
import UIKit

struct UserViewModel {
    let avatar_url: String
    let name: String
    let type: String
    
    init(user: User) {
        self.avatar_url = user.avatar_url ?? ""
        self.name = user.name ?? ""
        self.type = user.type ?? ""
    }
}
