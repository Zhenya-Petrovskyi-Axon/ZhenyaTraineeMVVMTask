//
//  UserEndPoint.swift
//  MVVM_RandomUser
//
//  Created by Evhen Petrovskyi on 22.04.2021.
//

import Foundation

// MARK: - Users
struct Users: Codable {
    let results: [User]
    let info: Info
}
