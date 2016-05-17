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
        let y: CGFloat = 40
        let width = containerView!.frame.width
        let height = containerView!.frame.height - y
        let rect = CGRect(x: x, y: y, width: width, height: height)
        return rect
    }
    
    override func presentationTransitionWillBegin() {
        dimmingView.frame = containerView!.frame
        dimmingView.backgroundColor = .blackColor()
        dimmingView.alpha = 0.0
        dimmingView.addSubview(presentedViewController.view)
        containerView?.addSubview(dimmingView)
        
        UIView.animateWithDuration(0.3) {
            self.dimmingView.alpha = 0.5
        }
    }
    
    override func dismissalTransitionWillBegin() {
        UIView.animateWithDuration(0.3, animations: {
            self.dimmingView.alpha = 0.0
        }) { completed in
            self.dimmingView.removeFromSuperview()
        }
    }
    
}
