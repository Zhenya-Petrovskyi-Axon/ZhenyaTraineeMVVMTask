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
        
        // MARK: Used for overFetching check of max in total usersData from server
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
            
            cell.userCellName.text = self.usersData[indexPath.row].fullname
            
            if let url = URL(string: "\(self.usersData[indexPath.row].picture.large)") {
                cell.userCellImage.kf.setImage(with: url)
            }
            
            cell.userCellImage.layer.masksToBounds = true
            cell.userCellImage.layer.cornerRadius = (cell.userCellImage.frame.height / 2)
            
        }
    }
}
