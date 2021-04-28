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
    
    // MARK: - Get Users Data from server
    func getUsersData() {
        
        // MARK: Used to check overFetching from server
        if (usersArrayitemsCount + Int(apiManager.resultsPerPage)) > Int((apiManager.maxUsersCount)) {
            return
        }
        
        // MARK: Make a call to get users
        apiManager.getUsers { [weak self] userData in
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
    
    // MARK: - Setup displayable cell
    func setUpCell(_ cell: UserCollectionViewCell, indexPath: IndexPath) {
        
        DispatchQueue.main.async {
            
            cell.userCellName.text = self.usersData[indexPath.row].fullname
            
            if let url = URL(string: "\(self.usersData[indexPath.row].picture.large)") {
                cell.userCellImage.kf.setImage(with: url)
            }
            
            
            
        }
    }
}
