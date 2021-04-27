//
//  AnimatorClass.swift
//  MVVM_RandomUser
//
//  Created by Evhen Petrovskyi on 26.04.2021.
//

import UIKit

// B2 - 8
final class Animator: NSObject, UIViewControllerAnimatedTransitioning {
    
    // B2 - 9
    static let duration: TimeInterval = 1.25
    
    private let type: PresentationType
    private let mainViewController: MainVC
    private let detailViewController: DetailsVC
    private let userImageSnapshot: UIView
    private let cellImageViewRect: CGRect
    
    // B2 - 10
    init?(type: PresentationType, firstView: MainVC, secondView: DetailsVC, userImageSnapshot: UIView) {
        self.type = type
        self.mainViewController = firstView
        self.detailViewController = secondView
        self.userImageSnapshot = userImageSnapshot
        
        guard let window = firstView.view.window ?? secondView.view.window,
              let selectedCell = firstView.selectedCell
        else { return nil }
        
        // B2 - 11
        self.cellImageViewRect = selectedCell.userImage.convert(selectedCell.userImage.bounds, to: window)
    }
    
    // B2 - 12
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return Self.duration
    }
    
    
    // B2 - 13
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        // B2 - 18
        let containerView = transitionContext.containerView
        
        // B2 - 19
        guard let toView = detailViewController.view
        else {
            transitionContext.completeTransition(false)
            print("Failed transition")
            return
        }
        
        containerView.addSubview(toView)
        
        // B3 - 21
        guard let selectedCell = mainViewController.selectedCell,
              let window = mainViewController.view.window ?? detailViewController.view.window,
              let mainVCImageSnapshot = selectedCell.userImage.snapshotView(afterScreenUpdates: true),
              let detailVCImageSnapshot = detailViewController.userImage.snapshotView(afterScreenUpdates: true)
        else {
            transitionContext.completeTransition(true)
            return
        }
        
        let isPresenting = type.isPresenting
        
        // B3 - 22
        let imageViewSnapshot: UIView
        
        if isPresenting {
            imageViewSnapshot = mainVCImageSnapshot
        } else {
            imageViewSnapshot = detailVCImageSnapshot
        }
        
        // B3 - 23
        toView.alpha = 0
        
        containerView.addSubview(imageViewSnapshot)
        
        // B3 - 25
        let detailVCImageViewRect = detailViewController.userImage.convert(detailViewController.userImage.bounds, to: window)
        
        imageViewSnapshot.frame = isPresenting ? cellImageViewRect : detailVCImageViewRect
        
        // B3 - 27
        UIView.animateKeyframes(withDuration: Self.duration, delay: 0, options: .calculationModeCubic, animations: {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1) {
                // B3 - 28
                imageViewSnapshot.frame = isPresenting ? detailVCImageViewRect : self.cellImageViewRect
            }
        }, completion: { _ in
            // B3 - 29
            imageViewSnapshot.removeFromSuperview()
            
            // B3 - 30
            toView.alpha = 1
            
            // B3 - 31
            transitionContext.completeTransition(true)
        })
        
    }
}

// B2 - 14
enum PresentationType {
    
    case present
    case dismiss
    
    var isPresenting: Bool {
        return self == .present
    }
}

