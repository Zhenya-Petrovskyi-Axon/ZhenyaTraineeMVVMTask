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
    private let firstViewController: MainViewController
    private let secondViewController: UserDetailsVC
    private let selectedCellImageViewSnapshot: UIView
    private let cellImageViewRect: CGRect

    // B2 - 10
    init?(type: PresentationType, firstViewController: MainViewController, secondViewController: UserDetailsVC, selectedCellImageViewSnapshot: UIView) {
        self.type = type
        self.firstViewController = firstViewController
        self.secondViewController = secondViewController
        self.selectedCellImageViewSnapshot = selectedCellImageViewSnapshot

        guard let window = firstViewController.view.window ?? secondViewController.view.window,
            let selectedCell = firstViewController.selectedCell
            else { return nil }

        // B2 - 11
        self.cellImageViewRect = selectedCell.userImage.convert(selectedCell.userImage.bounds, to: window)
    }

    // B2 - 12
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return Self.duration
    }

    // B2 - 13

    // B2 - 13
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        // B2 - 18
        let containerView = transitionContext.containerView

        // B2 - 19
        guard let toView = secondViewController.view
            else {
                transitionContext.completeTransition(false)
                return
        }

        containerView.addSubview(toView)

        // B2 - 20
        transitionContext.completeTransition(true)
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

