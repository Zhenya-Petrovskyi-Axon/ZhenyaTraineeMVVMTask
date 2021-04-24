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
        
        userNameLabel.text = "My name: \(user.fullname)"
        userGenderLabel.text = "Gender: \(user.gender.rawValue)"
        userDobLabel.text = "Woth born: \(formatDate(date: user.dob.date))"
        userNationalityLabel.text = user.nat
        cellPhoneLabel.text = "Phone number: \(user.cell) "
        
        DispatchQueue.main.async {
            let url = URL(string: "\(user.picture.large )")
            self.userImage.kf.setImage(with: url)
        }
        
        setupUserImageView()
    }
    
    func setupUserImageView() {
        userImage.layer.masksToBounds = true
        userImage.layer.cornerRadius = (userImage.frame.height / 2)
    }
    
    // MARK - Used to formate DOB
    func formatDate(date: String) -> String {
        
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateStyle = .medium
        
        let dateObj: Date? = dateFormatterGet.date(from: date)
        
        return dateFormatter.string(from: dateObj!)
        
    }
    
}
