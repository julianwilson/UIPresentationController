//
//  AnimatedTransitioning.swift
//  CustomPresentationAndAnimation
//
//  Created by Garric Nahapetian on 5/20/16.
//  Copyright © 2016 Garric Nahapetian. All rights reserved.
//

import UIKit

class AnimatedTransitioning: NSObject, UIViewControllerAnimatedTransitioning {
    
    var isPresenting = false
    internal var operation: UINavigationControllerOperation = .None
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 0.3
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
//        print("animateTransition")
        guard let container = transitionContext.containerView()
        , fromView = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)
        , toView = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)
        
        else { return }
        
        let containerFrame = container.frame
        var fromViewStartFrame = transitionContext.initialFrameForViewController(fromView)
        var toViewStartFrame = transitionContext.initialFrameForViewController(toView)
        let toViewFinalFrame = transitionContext.finalFrameForViewController(toView)
        var fromViewFinalFrame = transitionContext.finalFrameForViewController(fromView)
        
//        print("isPresenting: \(isPresenting)")
//        print("fromView")
//        print(fromView)
//        print("toView")
//        print(toView)
        
        fromViewStartFrame = containerFrame
        fromViewFinalFrame.size.width = containerFrame.width
        fromViewFinalFrame.size.height = containerFrame.height
        fromViewFinalFrame.origin.x = isPresenting ? 0 : -containerFrame.width
        
        toViewStartFrame.size.width = containerFrame.width
        toViewStartFrame.size.height = containerFrame.height
        toViewStartFrame.origin.x = isPresenting ? -containerFrame.width : 0
        toViewStartFrame.origin.y = 0

        if operation == .Push {
            toViewStartFrame.origin.x = container.frame.width
            fromViewFinalFrame.origin.x -= containerFrame.width
        } else if operation == .Pop {
            toViewStartFrame.origin.x = -container.frame.width
            fromViewFinalFrame.origin.x += containerFrame.width
        }
        
        if isPresenting {
            fromView.view.frame = fromViewStartFrame
        }
        toView.view.frame = toViewStartFrame
        
        if isPresenting {
            container.addSubview(toView.view)
        }
        
//        print("fromViewFinalFrame")
//        print(fromViewFinalFrame)
//        print("toViewFinalFrame")
//        print(toViewFinalFrame)

        UIView.animateWithDuration(transitionDuration(transitionContext), animations: {
            fromView.view.frame = fromViewFinalFrame
            toView.view.frame = toViewFinalFrame
        }) { completed in
            if completed {
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled())
                if self.operation == .Pop {
                    fromView.view.removeFromSuperview()
                }
            }
        }
    }
}







