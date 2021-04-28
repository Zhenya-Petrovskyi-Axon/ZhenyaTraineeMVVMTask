//
//  UserCollectionViewCell.swift
//  MVVM_RandomUser
//
//  Created by Evhen Petrovskyi on 22.04.2021.
//

import UIKit

struct UserCellModel {
    let userCellImage: String
    let userCellName: String
}

class UserCollectionViewModel {
    let userCellModel: UserCellModel
    init(userModel: UserCellModel) {
        self.userCellModel = userModel
    }
}

class UserCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var userCellImage: UIImageView!
    @IBOutlet weak var userCellName: UILabel!
    
    var viewModel: UserCollectionViewModel! {
        didSet {
            userCellName.text = viewModel.userCellModel.userCellName
            if let url = URL(string: "\(viewModel.userCellModel.userCellImage)") {
                userCellImage.kf.setImage(with: url)
            }
        }
    }
    
    func setupCellImageView() {
        
        userCellImage.layer.masksToBounds = true
        userCellImage.layer.cornerRadius = (userCellImage.frame.height / 2)
        userCellImage.layer.borderWidth = 3
        userCellImage.layer.borderColor = UIColor.systemGray.cgColor
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupCellImageView()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}
