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
    @IBOutlet weak var userLocationLabel: UILabel!
    @IBOutlet weak var telDescriptionLabel: UILabel!
    @IBOutlet weak var usersPhoneButtonText: UIButton!
    
    var user: User?
    
    private var userPhoneNumberToCall = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        
    }
    
    // MARK: - Setup User info
    func setupView() {
        
        guard let user = user else { return }
        
        userNameLabel.text = "My name: \(user.fullname)"
        userGenderLabel.text = "Gender: \(user.gender.rawValue)"
        userDobLabel.text = "Woth born: \(formatDate(date: user.dob.date))"
        userLocationLabel.text = "From: \(user.location.country)"
        
        // Set Button text with users phone number
        usersPhoneButtonText.setTitle("\(user.cell)", for: .normal)
        // Set Users
        userPhoneNumberToCall = user.cell
        
        telDescriptionLabel.text = "Phone number:"
        
        roundImageView()
        
        setUserImage()
    }
    
    // MARK: - Used to get & set image from url
    func setUserImage() {
        if user?.picture.large != "" {
            
            let url = URL(string: "\(user?.picture.large ?? "")")
            self.userImage.kf.setImage(with: url)
            
        }
    }
    
    // MARK: - Used to set up image to be round
    func roundImageView() {
        userImage.layer.masksToBounds = true
        userImage.layer.cornerRadius = (userImage.frame.height / 2)
    }
    
    // MARK: - Used to formate DOB
    func formatDate(date: String) -> String {
        
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateStyle = .medium
        
        let dateObj: Date? = dateFormatterGet.date(from: date)
        
        return dateFormatter.string(from: dateObj!)
        
    }
    
    // MARK: - Make a call using users phone number
    @IBAction func callButtonAction(_ sender: UIButton) {
        if let phoneCallURL = URL(string: "tel://\(userPhoneNumberToCall)") {
            print("User tap to call \(user!.fullname)")
            let application = UIApplication.shared
            if (application.canOpenURL(phoneCallURL)) {
                let alert = UIAlertController(title: "", message: "Call to \n\(String(describing: self.user!.fullname))?", preferredStyle: .alert)
                let yesPressed = UIAlertAction(title: "Yes", style: .default, handler: { (action) in
                    application.open(phoneCallURL, options: [:], completionHandler: nil)
                    print("App will call on real device")
                })
                let noPressed = UIAlertAction(title: "No", style: .default, handler: { (action) in
                    print("User decided not to call")
                })
                alert.addAction(yesPressed)
                alert.addAction(noPressed)
                present(alert, animated: true, completion: nil)
            }
        }
    }
    
}
