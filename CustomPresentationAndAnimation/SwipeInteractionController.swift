import UIKit

class SwipeInteractionController: UIPercentDrivenInteractiveTransition {
    
    var interactionInProgress = false
    
    private var shouldCompleteTransition = false
    private weak var viewController: UIViewController!
    
    func wireToViewController(viewController: UIViewController!) {
        self.viewController = viewController
        prepareGestureRecognizerInView(viewController.view)
    }
    
    private func prepareGestureRecognizerInView(view: UIView) {
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(handleGesture(_:)))
        //gesture.edges = UIRectEdge.Right
        view.addGestureRecognizer(gesture)
    }
    
    func handleGesture(gestureRecognizer: UIScreenEdgePanGestureRecognizer) {
        let translation = gestureRecognizer.translationInView(gestureRecognizer.view!.superview!)
        var progress = (abs(translation.x) / 285)
        progress = CGFloat(fminf(fmaxf(Float(progress), 0.0), 1.0))
        
        switch gestureRecognizer.state {
            
        case .Began:
            interactionInProgress = true
            viewController.dismissViewControllerAnimated(true, completion: nil)
            
        case .Changed:
            shouldCompleteTransition = progress > 0.5
            updateInteractiveTransition(progress)
            
        case .Cancelled:
            interactionInProgress = false
            cancelInteractiveTransition()
            
        case .Ended:
            interactionInProgress = false
            
            if !shouldCompleteTransition {
                cancelInteractiveTransition()
            } else {
                finishInteractiveTransition()
            }
            
        default:
            print("Unsupported")
        }
    }
}
