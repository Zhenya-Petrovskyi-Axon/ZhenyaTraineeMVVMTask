//
//  UserDetailsVC.swift
//  MVVM_RandomUser
//
//  Created by Evhen Petrovskyi on 24.04.2021.
//

import UIKit

class UserDetailsVC: ViewController {
    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userGenderLabel: UILabel!
    @IBOutlet weak var userDobLabel: UILabel!
    @IBOutlet weak var userNationalityLabel: UILabel!
    @IBOutlet weak var cellPhoneLabel: UILabel!
    
    var user: User?

    override func viewDidLoad() {
        super.viewDidLoad()

    }
   
}
