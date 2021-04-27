//
//  AnimatorClass.swift
//  MVVM_RandomUser
//
//  Created by Evhen Petrovskyi on 26.04.2021.
//

import UIKit

// MARK: - Main animator class
final class Animator: NSObject, UIViewControllerAnimatedTransitioning {
    
    static let duration: TimeInterval = 1.00
    
    private let type: PresentationType
    private let mainViewController: MainVC
    private let detailViewController: DetailsVC
    private var selectedCellImageViewSnapshot: UIView
    private let cellImageViewRect: CGRect
    
    // Custom initializer that assigns all declared properties
    init?(type: PresentationType, firstView: MainVC, secondView: DetailsVC, userImageSnapshot: UIView) {
        self.type = type
        self.mainViewController = firstView
        self.detailViewController = secondView
        self.selectedCellImageViewSnapshot = userImageSnapshot
        
        guard let window = firstView.view.window ?? secondView.view.window,
              let selectedCell = firstView.selectedCell
        else {
            // In case of failure use default animation
            return nil }
        
        // Getting the Frame of the Image View of the Cell relative to the window’s frame
        self.cellImageViewRect = selectedCell.userCellImage.convert(selectedCell.userCellImage.bounds, to: window)
    }
    
    // Return wanted animation duration required by UIViewControllerContextTransitioning protocol
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return Self.duration
    }
    
    
    // MARK: - All of the transition logic and animations
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        // Container as a view that used to run animations on
        let containerView = transitionContext.containerView
        
        guard let toView = detailViewController.view
        else {
            transitionContext.completeTransition(false)
            print("Wrong transition destination")
            return
        }
        
        containerView.addSubview(toView)
        
        // Assigning the window of the screen that for current presentation or dissmissal
        guard let selectedCell = mainViewController.selectedCell,
              let window = mainViewController.view.window ?? detailViewController.view.window,
              let mainVCImageSnapshot = selectedCell.userCellImage.snapshotView(afterScreenUpdates: true),
              let detailVCImageSnapshot = detailViewController.userImage.snapshotView(afterScreenUpdates: true)
        else {
            transitionContext.completeTransition(true)
            return
        }
        
        let isPresenting = type.isPresenting
        
        // Instantiate a background and fade views
        let backgroundView: UIView
        let fadeView = UIView(frame: containerView.bounds)
        fadeView.backgroundColor = detailViewController.view.backgroundColor
        
        if isPresenting {
            selectedCellImageViewSnapshot = mainVCImageSnapshot
            backgroundView = UIView(frame: containerView.bounds)
            backgroundView.addSubview(fadeView)
            fadeView.alpha = 0
        } else {
            backgroundView = mainViewController.view.snapshotView(afterScreenUpdates: true) ?? fadeView
            backgroundView.addSubview(fadeView)
        }
        
        // Fading View that is presenting
        toView.alpha = 0
        
        [backgroundView, selectedCellImageViewSnapshot, detailVCImageSnapshot].forEach { containerView.addSubview($0) }
        
        // Getting frame of DetailVC to transition from cell to view
        let detailVCImageViewRect = detailViewController.userImage.convert(detailViewController.userImage.bounds, to: window)
        
        // Which frame size to use
        [selectedCellImageViewSnapshot, detailVCImageSnapshot].forEach {
            $0.frame = isPresenting ? cellImageViewRect : detailVCImageViewRect
        }
        
        // Wich transparency to use in wich case of presentation
        detailVCImageSnapshot.alpha = isPresenting ? 0 : 1
        selectedCellImageViewSnapshot.alpha = isPresenting ? 1 : 0
        
        // MARK: - Animation
        UIView.animateKeyframes(withDuration: Self.duration, delay: 0, options: .calculationModeCubic, animations: {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1) {
                
                // Which frame size's of snapshots to use with presenting or dissmissing animation's
                self.selectedCellImageViewSnapshot.frame = isPresenting ? detailVCImageViewRect : self.cellImageViewRect
                detailVCImageSnapshot.frame = isPresenting ? detailVCImageViewRect : self.cellImageViewRect
                
                // Changing alpha of fade view for the fade animation
                fadeView.alpha = isPresenting ? 1 : 0
            }
            
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.6) {
                // Which transparency for snapshots to use when presentation animates
                self.selectedCellImageViewSnapshot.alpha = isPresenting ? 0 : 1
                detailVCImageSnapshot.alpha = isPresenting ? 1 : 0
            }
            // MARK: -  What to do when transition is completed
        }, completion: { _ in
            
            // Cleanup and remove all the views used during transition
            self.selectedCellImageViewSnapshot.removeFromSuperview()
            detailVCImageSnapshot.removeFromSuperview()
            backgroundView.removeFromSuperview()
            
            // non-transparent again
            toView.alpha = 1
            
            transitionContext.completeTransition(true)
        })
        
    }
}

// Used to pass to Animator to define which animation to use
enum PresentationType {
    
    case present
    case dismiss
    
    var isPresenting: Bool {
        return self == .present
    }
}

