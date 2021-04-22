//
//  UsersViewModel.swift
//  MVVM_RandomUser
//
//  Created by Evhen Petrovskyi on 22.04.2021.
//

import Foundation

class UsersViewModel: NSObject {
    
    private var apiManager: APIManager!
    
    override init() {
        super.init()
        self.apiManager = APIManager()
        getUsersData()
    }
    
    func getUsersData() {
        apiManager.getUsers { result in
            switch result {
            case .success(let users):
                print(users)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
