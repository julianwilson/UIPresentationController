//
//  PresentedViewController.swift
//  CustomPresentationAndAnimation
//
//  Created by Garric Nahapetian on 5/17/16.
//  Copyright © 2016 Garric Nahapetian. All rights reserved.
//

import UIKit

protocol PresentedViewControllerDelegate: class {
    func dismiss()
}

class PresentedViewController: UIViewController {

    weak var delegate: PresentedViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .redColor()

        func setupButton() {
            let button = UIButton()
            button.translatesAutoresizingMaskIntoConstraints = false
            button.setTitle("Hide", forState: .Normal)
            button.addTarget(self, action: #selector(hideButtonTapped(_:)), forControlEvents: .TouchUpInside)
            view.addSubview(button)
            
            NSLayoutConstraint(item: button, attribute: .Top, relatedBy: .Equal, toItem: view, attribute: .TopMargin, multiplier: 1.0, constant: 0.0).active = true
            NSLayoutConstraint(item: button, attribute: .CenterX, relatedBy: .Equal, toItem: view, attribute: .CenterX, multiplier: 1.0, constant: 0.0).active = true
            
        }
        setupButton()

    }
    
    func hideButtonTapped(sender: UIButton) {
        delegate?.dismiss()
    }
    
}

extension PresentedViewController: UIViewControllerTransitioningDelegate {

    func presentationControllerForPresentedViewController(presented: UIViewController, presentingViewController presenting: UIViewController, sourceViewController source: UIViewController) -> UIPresentationController? {
        return PresentationController(presentedViewController: presented, presentingViewController: presenting)
    }

}
















