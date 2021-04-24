//
//  UsersViewModel.swift
//  MVVM_RandomUser
//
//  Created by Evhen Petrovskyi on 22.04.2021.
//

import Foundation
import Kingfisher

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
    
    func setUpCell(_ cell: UserCollectionViewCell, indexPath: IndexPath) {
        
        DispatchQueue.main.async {
            
            cell.userName.text = self.usersData[indexPath.row].fullname
            
            if let url = URL(string: "\(self.usersData[indexPath.row].picture.large)") {
                cell.userImage.kf.setImage(with: url)
            }
            
            cell.userImage.layer.masksToBounds = true
            cell.userImage.layer.cornerRadius = (cell.userImage.frame.width / 2)
            
        }
    }
}
