//
//  UsersViewModel.swift
//  MVVM_RandomUser
//
//  Created by Evhen Petrovskyi on 22.04.2021.
//

import Foundation

class UsersViewModel: NSObject {
    
    private var apiManager: APIManager!
    private(set) var usersData: [User]! {
        didSet {
            self.bindUsersViewModelToController()
        }
    }
    
    var bindUsersViewModelToController : (() -> ()) = {}

    override init() {
        super.init()
        self.apiManager = APIManager()
        getUsersData()
    }
    
    func getUsersData() {
        apiManager.getUsers { [weak self] userData in
            switch userData {
            case .success(let users):
                self?.usersData = users
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
