//
//  UsersViewModel.swift
//  MVVM_RandomUser
//
//  Created by Evhen Petrovskyi on 22.04.2021.
//

import Foundation
import Kingfisher

// MARK: - Model to handle with main ViewController
class UsersViewModel {
    
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
    
    // MARK: - Get users
    func getUsersData() {
        
        // MARK: Check to not overFetch usersData form server
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
    func setUpCell(_ cell: UserCollectionViewCell, indexPath: IndexPath) {
        
        DispatchQueue.main.async {
            
            cell.userName.text = self.usersData[indexPath.row].fullname
            
            if let url = URL(string: "\(self.usersData[indexPath.row].picture.large)") {
                cell.userImage.kf.setImage(with: url)
            }
            
            cell.userImage.layer.masksToBounds = true
            cell.userImage.layer.cornerRadius = (cell.userImage.frame.height / 2)
            
        }
    }
}
