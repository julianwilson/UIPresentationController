//
//  PresentedViewController.swift
//  CustomPresentationAndAnimation
//
//  Created by Garric Nahapetian on 5/17/16.
//  Copyright © 2016 Garric Nahapetian. All rights reserved.
//

import UIKit

class PresentedViewController: UIViewController {
    
    var animatedTrans = AnimatedTransitioning()
    let swipeInteractionController = SwipeInteractionController()

    weak var delegate: PresentedViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .redColor()
        view.alpha = 0.5

        let hideButton = UIButton()
        let pushbutton = UIButton()

        func setupHideButton() {
            hideButton.translatesAutoresizingMaskIntoConstraints = false
            hideButton.setTitle("Hide", forState: .Normal)
            hideButton.addTarget(self, action: #selector(hideButtonTapped(_:)), forControlEvents: .TouchUpInside)
            view.addSubview(hideButton)
            
            NSLayoutConstraint(item: hideButton, attribute: .CenterY, relatedBy: .Equal, toItem: view, attribute: .CenterY, multiplier: 1.0, constant: 0.0).active = true
            NSLayoutConstraint(item: hideButton, attribute: .CenterX, relatedBy: .Equal, toItem: view, attribute: .CenterX, multiplier: 1.0, constant: 0.0).active = true
            
        }
        func setupPushButton() {
            pushbutton.translatesAutoresizingMaskIntoConstraints = false
            pushbutton.setTitle("Push", forState: .Normal)
            pushbutton.addTarget(self, action: #selector(pushButtonTapped(_:)), forControlEvents: .TouchUpInside)
            view.addSubview(pushbutton)
            
            NSLayoutConstraint(item: pushbutton, attribute: .Top, relatedBy: .Equal, toItem: hideButton, attribute: .Bottom, multiplier: 1.0, constant: 0.0).active = true
            NSLayoutConstraint(item: pushbutton, attribute: .CenterX, relatedBy: .Equal, toItem: view, attribute: .CenterX, multiplier: 1.0, constant: 0.0).active = true
        }
        setupHideButton()
        setupPushButton()
        
        swipeInteractionController.wireToViewController(self)
    }
    
    func hideButtonTapped(sender: UIButton) {
        delegate?.dismiss()
    }
    
    func pushButtonTapped(sender: UIButton) {
        let pushedViewController = PushedViewController()
        pushedViewController.delegate = self
        navigationController?.pushViewController(pushedViewController, animated: true)
    }
    
}

extension PresentedViewController: UIViewControllerTransitioningDelegate {

    func presentationControllerForPresentedViewController(presented: UIViewController, presentingViewController presenting: UIViewController, sourceViewController source: UIViewController) -> UIPresentationController? {
        return PresentationController(presentedViewController: presented, presentingViewController: presenting)
    }
    
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        animatedTrans.isPresenting = true
        animatedTrans.operation = .None
        return animatedTrans
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        animatedTrans.isPresenting = false
        animatedTrans.operation = .None
        return animatedTrans
    }
    
    func interactionControllerForDismissal(animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return swipeInteractionController.interactionInProgress ? swipeInteractionController : nil
    }

}

extension PresentedViewController: UINavigationControllerDelegate {
    
    func navigationController(navigationController: UINavigationController, animationControllerForOperation operation: UINavigationControllerOperation, fromViewController fromVC: UIViewController, toViewController toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        animatedTrans.isPresenting = true
        animatedTrans.operation = operation
        return animatedTrans
    }
    
}

extension PresentedViewController: PushedViewControllerDelegate {
    
    func pop() {
        navigationController?.popViewControllerAnimated(true)
    }
}











