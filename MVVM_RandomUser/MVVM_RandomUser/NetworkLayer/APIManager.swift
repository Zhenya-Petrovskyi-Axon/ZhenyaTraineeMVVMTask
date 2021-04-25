//
//  NetworkManager.swift
//  MVVM_RandomUser
//
//  Created by Evhen Petrovskyi on 21.04.2021.
//

import Foundation

// MARK: - Session Errors
enum NetworkError: Error {
    case urlIsNotValid
    case noDataToRecieve
    case wrongResponse
    case unableToDecode
    case responseIsNotValid(Int)
}

// MARK: - Protocols
protocol APIManagerProtocol: class {
    func getUsers(completion: @escaping (Result<[User], NetworkError>) -> Void)
}

// MARK: - Network Data Manager
class APIManager: APIManagerProtocol {
    
    private let baseUrl = "https://randomuser.me/api/?seed=abc&results="
    private let resultsForPage = "&page="
    public var resultsPerPage: Int {
        return 20
    }
    
    public var maxUsersCount: Int {
       return 5000
    }
    
    private let session = URLSession.shared
    private let decoder = JSONDecoder()
    
    // MARK: - Main function to get users
    func getUsers(completion: @escaping (Result<[User], NetworkError>) -> Void) {
        
        let page = Int.random(in: 1...(maxUsersCount / resultsPerPage))
        
        let fullUrl = "\(baseUrl)\(resultsPerPage)\(resultsForPage)\(page)"
        
        guard let url = URL(string: fullUrl) else {
            completion(.failure(.urlIsNotValid))
            return
        }
        
        print("Loading data from url: \(url)")
        
        session.dataTask(with: url) { data, response, error in
            
            if error != nil {
                completion(.failure(.noDataToRecieve))
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                completion(.failure(.wrongResponse))
                return
            }
            
            switch response.statusCode {
            case 200...201:
                guard let data = data else {
                    completion(.failure(.noDataToRecieve))
                    return
                }
                do {
                    let users = try self.decoder.decode(Users.self, from: data)
                    completion(.success(users.results))
                } catch  {
                    completion(.failure(.unableToDecode))
                }
            default:
                completion(.failure(.responseIsNotValid(response.statusCode)))
            }
        }.resume()
    }
    
}

