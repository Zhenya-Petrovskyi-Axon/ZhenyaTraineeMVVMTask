//
//  UsersViewModel.swift
//  MVVM_RandomUser
//
//  Created by Evhen Petrovskyi on 22.04.2021.
//

import Foundation
import Kingfisher

// MARK: - Model to handle with main ViewController
class MainViewModel {
    
    private var apiManager: APIManager!
    private(set) var usersData: [User] = [] {
        didSet {
            self.didLoadUsers()
        }
    }
    
    private var usersArrayitemsCount: Int {
        return usersData.count
    }
    
    var didLoadUsers : (() -> ()) = {}
    
    init() {
        self.apiManager = APIManager()
        getUsersData()
    }
    
    var currentPage: Int {
        return Int.random(in: 1...Int(apiManager.maxUsersCount / apiManager.resultsPerPage))
    }
    
    // MARK: - Get Users Data from server
    func getUsersData() {
        
        // MARK: Used to check overFetching from server
        if (usersArrayitemsCount + Int(apiManager.resultsPerPage)) > Int((apiManager.maxUsersCount)) {
            return
        }
        
        // MARK: Make a call to get users
        apiManager.getUsers(page: currentPage) { [weak self] userData in
            switch userData {
            case .success(let users):
                self?.usersData.append(contentsOf: users)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    // MARK: - Setup displayable cell
    func viewModelForCell(_ indexPath: IndexPath) -> UserCollectionViewModel {
        let user = usersData[indexPath.row]
        return UserCollectionViewModel(userModel: UserCellModel(userCellImage: user.picture.medium, userCellName: user.fullname))
    }
    
}
