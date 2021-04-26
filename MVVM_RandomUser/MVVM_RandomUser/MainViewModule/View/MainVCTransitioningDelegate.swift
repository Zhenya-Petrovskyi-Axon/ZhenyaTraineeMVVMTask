//
//  MainVCTransitioningDelegate.swift
//  MVVM_RandomUser
//
//  Created by Evhen Petrovskyi on 26.04.2021.
//

import UIKit

extension MainViewController: UIViewControllerTransitioningDelegate {

    // B1 - 2
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return nil
    }

    // B1 - 3
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return nil
    }
}
