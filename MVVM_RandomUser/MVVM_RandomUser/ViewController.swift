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
    
    // MARK: - Call usersViewModel to bind data
    func setupBindings() {
        self.usersViewModel.didLoadUsers = { [weak self] in
            self?.updateDataSource()
        }
    }
    
    // MARK: - Update Data
    func updateDataSource() {
        DispatchQueue.main.async { [weak self] in
            self?.usersCollectionView.reloadData()
        }
    }
    
    // MARK: - Show User Cell
    func registerNib() {
        self.usersCollectionView.register(UINib(nibName: "UserCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "UserCollectionViewCell")
    }
    
    // MARK: - Set up delegates
    func setDelegates() {
        usersCollectionView.delegate = self
        usersCollectionView.dataSource = self
    }
    
    // MARK: - Used to get more users on scroll
    func getMoreUsers() {
        usersViewModel.getUsersData()
    }
    
    // MARK: - Send chosed user data to DetailVC
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToDetailVC" {
            
            let vc =  segue.destination as? UserDetailsVC
            guard let indexPath = sender as? IndexPath else { return }
            
            vc?.user = usersViewModel.usersData[indexPath.row]
            print("User decided to get info of \(usersViewModel.usersData[indexPath.row].fullname)")
            
        }
    }
    
}

extension ViewController: UICollectionViewDelegate {
    
    // MARK: - When scrolled to the bottom - get more users
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
    
    // MARK: - Call Segue to DetailVC with tap on desired cell
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "goToDetailVC", sender: indexPath)
    }
    
    
}
