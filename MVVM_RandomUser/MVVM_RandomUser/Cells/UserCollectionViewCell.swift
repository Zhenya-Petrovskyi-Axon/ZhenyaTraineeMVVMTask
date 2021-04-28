//
//  UserCollectionViewCell.swift
//  MVVM_RandomUser
//
//  Created by Evhen Petrovskyi on 22.04.2021.
//

import UIKit

class UserCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var userCellImage: UIImageView!
    @IBOutlet weak var userCellName: UILabel!
    
    private let viewModel = MainViewModel()
    
//    private lazy var setupOnce: Void = {
//        userCellImage.layer.masksToBounds = true
//        userCellImage.layer.cornerRadius = (userCellImage.frame.height / 2)
//        userCellImage.layer.borderWidth = 3
//        userCellImage.layer.borderColor = UIColor.systemGray.cgColor
//        //        layer.shadowOffset = CGSize(width: 0, height: 1.0)
//        //        layer.shadowRadius = 1.0
//        //        layer.shadowOpacity = 0.2
//        //        layer.masksToBounds = false
//        //        layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.contentView.layer.cornerRadius).cgPath
//    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
//        _ = setupOnce
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}
