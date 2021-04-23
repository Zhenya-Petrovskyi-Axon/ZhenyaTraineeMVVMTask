//
//  UsersViewModel.swift
//  MVVM_RandomUser
//
//  Created by Evhen Petrovskyi on 22.04.2021.
//

import Foundation

class UsersViewModel {
    
    private var apiManager: APIManager!
    private(set) var usersData: [User] = [] {
        didSet {
            self.didLoadUsers()
        }
    }
    
    var didLoadUsers : (() -> ()) = {}
    
    init() {
        self.apiManager = APIManager()
        getUsersData()
    }
    
    func getUsersData() {
        apiManager.getUsers { [weak self] userData in
            switch userData {
            case .success(let users):
                self?.usersData.append(contentsOf: users)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func getMoreUsersData() {
        apiManager.getUsers { [weak self] userData in
            switch userData {
            case .success(let users):
                self?.usersData.append(contentsOf: users)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
