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
    private var selectedCellImageViewSnapshot: UIView
    private let cellImageViewRect: CGRect
    
    // B2 - 10
    init?(type: PresentationType, firstView: MainVC, secondView: DetailsVC, userImageSnapshot: UIView) {
        self.type = type
        self.mainViewController = firstView
        self.detailViewController = secondView
        self.selectedCellImageViewSnapshot = userImageSnapshot
        
        guard let window = firstView.view.window ?? secondView.view.window,
              let selectedCell = firstView.selectedCell
        else { return nil }
        
        // B2 - 11
        self.cellImageViewRect = selectedCell.userCellImage.convert(selectedCell.userCellImage.bounds, to: window)
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
              let mainVCImageSnapshot = selectedCell.userCellImage.snapshotView(afterScreenUpdates: true),
              let detailVCImageSnapshot = detailViewController.userImage.snapshotView(afterScreenUpdates: true)
        else {
            transitionContext.completeTransition(true)
            return
        }
        
        let isPresenting = type.isPresenting
        
        // B5 - 40
            let backgroundView: UIView
            let fadeView = UIView(frame: containerView.bounds)
            fadeView.backgroundColor = detailViewController.view.backgroundColor
        
        // B4 - 33
        if isPresenting {
            selectedCellImageViewSnapshot = mainVCImageSnapshot
            
            // B5 - 41
                    backgroundView = UIView(frame: containerView.bounds)
                    backgroundView.addSubview(fadeView)
                    fadeView.alpha = 0
                } else {
                    backgroundView = mainViewController.view.snapshotView(afterScreenUpdates: true) ?? fadeView
                    backgroundView.addSubview(fadeView)
            
        }
        
        
        
        // B3 - 23
        toView.alpha = 0
        
        [backgroundView, selectedCellImageViewSnapshot, detailVCImageSnapshot].forEach { containerView.addSubview($0) }
        
        // B3 - 25
        let detailVCImageViewRect = detailViewController.userImage.convert(detailViewController.userImage.bounds, to: window)
        
        [selectedCellImageViewSnapshot, detailVCImageSnapshot].forEach {
                $0.frame = isPresenting ? cellImageViewRect : detailVCImageViewRect
            }
        
        detailVCImageSnapshot.alpha = isPresenting ? 0 : 1
        selectedCellImageViewSnapshot.alpha = isPresenting ? 1 : 0
        // B3 - 27
        UIView.animateKeyframes(withDuration: Self.duration, delay: 0, options: .calculationModeCubic, animations: {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1) {
                // B3 - 28
                self.selectedCellImageViewSnapshot.frame = isPresenting ? detailVCImageViewRect : self.cellImageViewRect
                detailVCImageSnapshot.frame = isPresenting ? detailVCImageViewRect : self.cellImageViewRect
                
                // B5 - 43
                            fadeView.alpha = isPresenting ? 1 : 0
                
            }
            
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.6) {
                        self.selectedCellImageViewSnapshot.alpha = isPresenting ? 0 : 1
                        detailVCImageSnapshot.alpha = isPresenting ? 1 : 0
            }
        }, completion: { _ in
            // B3 - 29
            self.selectedCellImageViewSnapshot.removeFromSuperview()
            detailVCImageSnapshot.removeFromSuperview()
            
            backgroundView.removeFromSuperview()
            
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

