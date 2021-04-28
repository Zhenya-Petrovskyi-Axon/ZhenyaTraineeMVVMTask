//
//  StringProtocol.swift
//  MVVM_RandomUser
//
//  Created by Evhen Petrovskyi on 28.04.2021.
//

import Foundation

extension StringProtocol {
    var firstUppercased: String { prefix(1).uppercased() + dropFirst() }
    var firstCapitalized: String { prefix(1).capitalized + dropFirst() }
}
