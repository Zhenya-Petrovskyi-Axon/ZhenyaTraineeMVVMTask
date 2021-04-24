//
//  NetworkManager.swift
//  MVVM_RandomUser
//
//  Created by Evhen Petrovskyi on 21.04.2021.
//

import Foundation

enum NetworkError: Error {
    case urlIsNotValid
    case noDataToRecieve
    case wrongResponse
    case unableToDecode
    case responseIsNotValid(Int)
}

protocol APIManagerProtocol: class {
    func getUsers(completion: @escaping (Result<[User], NetworkError>) -> Void)
}

class APIManager: APIManagerProtocol {
    
    private let baseUrl = "https://randomuser.me/api/?seed=abc&results="
    private let resultsForPage = "&page="
    private let resultsPerPage = 20
    private var currentPage = 1
    
    private let session = URLSession.shared
    private let decoder = JSONDecoder()
    
    func getUsers(completion: @escaping (Result<[User], NetworkError>) -> Void) {
        
        let fullUrl = "\(baseUrl)\(resultsPerPage)\(resultsForPage)\(currentPage)"
        
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
                    self.currentPage += 1
                } catch  {
                    completion(.failure(.unableToDecode))
                }
            default:
                completion(.failure(.responseIsNotValid(response.statusCode)))
            }
        }.resume()
    }
    
}

