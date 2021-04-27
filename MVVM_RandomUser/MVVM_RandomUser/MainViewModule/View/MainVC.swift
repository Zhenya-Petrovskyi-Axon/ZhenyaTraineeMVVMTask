//
//  ViewController.swift
//  MVVM_RandomUser
//
//  Created by Evhen Petrovskyi on 21.04.2021.
//

import UIKit

class MainVC: UIViewController {
    
    @IBOutlet weak var usersCollectionView: UICollectionView!
    
    var selectedCell: UserCollectionViewCell?
    var selectedCellImageViewSnapshot: UIView?
    
    private let usersViewModel = MainViewModel()
    
    var animator: Animator?
    
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
    
    // MARK: - Update Data Source
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
    
    // MARK: - Function to present DeatilVC
    func presentUserDetailVC(with data: User?) {
        let detailsVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "UserDetailsVC") as! DetailsVC
        
        detailsVC.transitioningDelegate = self
        
        detailsVC.modalPresentationStyle = .custom
        detailsVC.user = data
        
        present(detailsVC, animated: true)
        
    }
}

// MARK: - UICollectionView delegate & dataSource
extension MainVC: UICollectionViewDelegate {
    
    // MARK: - When scrolled to the bottom - get more users
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        if indexPath.row == usersViewModel.usersData.count - 3 {
            print("Bottom reached - user need's more data")
            getMoreUsers()
        }
    }
}

extension MainVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return usersViewModel.usersData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = usersCollectionView.dequeueReusableCell(withReuseIdentifier: "UserCollectionViewCell", for: indexPath) as! UserCollectionViewCell
        
        usersViewModel.setUpCell(cell, indexPath: indexPath)
        
        return cell
    }
    
    // MARK: - Present DetailsVC and init property's for animation usage
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        selectedCell = collectionView.cellForItem(at: indexPath) as? UserCollectionViewCell
        selectedCellImageViewSnapshot = selectedCell?.userCellImage.snapshotView(afterScreenUpdates: false)
        
        presentUserDetailVC(with: usersViewModel.usersData[indexPath.row])
    }
    
    
}
