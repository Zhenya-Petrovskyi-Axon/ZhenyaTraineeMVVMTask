//
//  ViewController.swift
//  MVVM_RandomUser
//
//  Created by Evhen Petrovskyi on 21.04.2021.
//

import UIKit
import Kingfisher

class ViewController: UIViewController {

    @IBOutlet weak var usersCollectionView: UICollectionView!
    
    private let usersViewModel = UsersViewModel()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        setDelegates()
        registerNib()
        setupBindings()
        
    }
    
    func setupBindings() {
        self.usersViewModel.didLoadUsers = { [weak self] in
            self?.updateDataSource()
        }
    }
    
    func updateDataSource() {
        DispatchQueue.main.async { [weak self] in
            self?.usersCollectionView.reloadData()
        }
       
    }
    
    func registerNib() {
        self.usersCollectionView.register(UINib(nibName: "UserCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "UserCollectionViewCell")
    }
    
    func setDelegates() {
        usersCollectionView.delegate = self
        usersCollectionView.dataSource = self
    }


}

extension ViewController: UICollectionViewDelegate {
    
}

extension ViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return usersViewModel.usersData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = usersCollectionView.dequeueReusableCell(withReuseIdentifier: "UserCollectionViewCell", for: indexPath) as! UserCollectionViewCell
        let item = usersViewModel.usersData[indexPath.row]
        
        cell.userName.text = item.fullname
        
        if let url = URL(string: "\(item.picture.large)") {
            cell.userImage.kf.setImage(with: url)
        }
        
        return cell
    }
    
}

//extension ViewController: UICollectionViewDelegateFlowLayout {
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//            return CGSize(width: UIScreen.main.bounds.width / 2.0, height: UIScreen.main.bounds.width / 2.0)
//        }
//    
//}
