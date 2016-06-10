//
//  PresentationController.swift
//  CustomPresentationAndAnimation
//
//  Created by Garric Nahapetian on 5/17/16.
//  Copyright © 2016 Garric Nahapetian. All rights reserved.
//

import UIKit

class PresentationController: UIPresentationController {
    
    let dimmingView = UIView()
    
    override func frameOfPresentedViewInContainerView() -> CGRect {
        let x: CGFloat = 0.0
        let y: CGFloat = 0.0
//        let width = containerView!.frame.width - 75
        let width: CGFloat = 285.0
        let height = containerView!.frame.height
        let rect = CGRect(x: x, y: y, width: width, height: height)
        return rect
    }
    
    override func presentationTransitionWillBegin() {
        guard let containerView = containerView else { return }
        
        containerView.addSubview(dimmingView)
        
        dimmingView.frame = UIScreen.mainScreen().bounds
        dimmingView.backgroundColor = .blackColor()
        dimmingView.alpha = 0.0
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dimmingViewTapped(_:)))
        dimmingView.addGestureRecognizer(tapGesture)

        self.presentingViewController.transitionCoordinator()?.animateAlongsideTransition({ _ in
            self.dimmingView.alpha = 0.5
        }, completion: nil)
    }
    
    func dimmingViewTapped(sender: AnyObject) {
        self.presentedViewController.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func dismissalTransitionWillBegin() {
        self.presentingViewController.transitionCoordinator()?.animateAlongsideTransition({ _ in
            self.dimmingView.alpha = 0.0
        }, completion: nil)
    }
    
}
