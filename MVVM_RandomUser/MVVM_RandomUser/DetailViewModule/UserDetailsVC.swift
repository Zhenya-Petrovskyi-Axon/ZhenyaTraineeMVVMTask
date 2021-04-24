//
//  UserDetailsVC.swift
//  MVVM_RandomUser
//
//  Created by Evhen Petrovskyi on 24.04.2021.
//

import UIKit
import Kingfisher

class UserDetailsVC: UIViewController {
    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userGenderLabel: UILabel!
    @IBOutlet weak var userDobLabel: UILabel!
    @IBOutlet weak var userNationalityLabel: UILabel!
    @IBOutlet weak var cellPhoneLabel: UILabel!
    
    var user: User?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        
    }
    
    func setupView() {
        
        guard let user = user else { return }
        
        userNameLabel.text = user.fullname
        userGenderLabel.text = "\(String(describing: user.gender))"
        userDobLabel.text = "\(String(describing: user.dob))"
        userNationalityLabel.text = user.nat
        cellPhoneLabel.text = user.cell
        
        if user.picture.large != "" {
            let url = URL(string: "\(user.picture.large )")
            DispatchQueue.main.async {
                self.userImage.kf.setImage(with: url)
            }
        }
        
        setupUserImageView()
    }
    
    func setupUserImageView() {
        userImage.layer.masksToBounds = true
        userImage.layer.cornerRadius = (userImage.frame.height / 2)
    }
   
}
