//
//  MainVCTransitioningDelegate.swift
//  MVVM_RandomUser
//
//  Created by Evhen Petrovskyi on 26.04.2021.
//

import UIKit

extension MainVC: UIViewControllerTransitioningDelegate {
    
    // MARK: - Preparing the properties to initialize an instance of Animator for presenting
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        // B2 - 16
        guard let firstViewController = presenting as? MainVC,
              let secondViewController = presented as? DetailsVC,
              let selectedCellImageViewSnapshot = selectedCellImageViewSnapshot
        else { return nil }
        
        animator = Animator(type: .present, firstView: firstViewController, secondView: secondViewController, userImageSnapshot: selectedCellImageViewSnapshot)
        return animator
    }
    
    // MARK: - Preparing the properties to initialize an instance of Animator for dissmissing
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        // B2 - 17
        guard let secondViewController = dismissed as? DetailsVC,
              let selectedCellImageViewSnapshot = selectedCellImageViewSnapshot
        else { return nil }
        
        animator = Animator(type: .dismiss, firstView: self, secondView: secondViewController, userImageSnapshot: selectedCellImageViewSnapshot)
        return animator
    }
}
