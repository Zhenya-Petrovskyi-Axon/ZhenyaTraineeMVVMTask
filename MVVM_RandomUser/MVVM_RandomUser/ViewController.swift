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
    
    func getMoreUsers() {
        usersViewModel.getUsersData()
    }
    
}

extension ViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        if indexPath.row == usersViewModel.usersData.count - 3 {
            print("Bottom reached - user need's more data")
            getMoreUsers()
        }
    }
}

extension ViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return usersViewModel.usersData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = usersCollectionView.dequeueReusableCell(withReuseIdentifier: "UserCollectionViewCell", for: indexPath) as! UserCollectionViewCell
        
        usersViewModel.setUpCell(cell, indexPath: indexPath)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        self.performSegue(withIdentifier: <#T##String#>, sender: <#T##Any?#>)
    }
    
    
}
