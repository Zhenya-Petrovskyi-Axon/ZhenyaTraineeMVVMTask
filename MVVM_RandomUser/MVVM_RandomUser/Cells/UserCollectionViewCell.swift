//
//  UserCollectionViewCell.swift
//  MVVM_RandomUser
//
//  Created by Evhen Petrovskyi on 22.04.2021.
//

import UIKit

class UserCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    
    var user: User? {
        didSet {
            userName.text = user?.fullname
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
