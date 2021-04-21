//
//  NetworkManager.swift
//  MVVM_RandomUser
//
//  Created by Evhen Petrovskyi on 21.04.2021.
//

import Foundation

enum NetworkError: Error {
    case urlIsNotValid
}

protocol UserManagerProtocol: class {
    func getUsers(completion: (Result<[User], NetworkError>) -> Void)
}

class UserManager: UserManagerProtocol {

    private let endpointUrl = ""
    private let perPage = 20
    private let currentPage = 1
    
    func getUsers(completion: (Result<[User], NetworkError>) -> Void) {
        
    }
}

