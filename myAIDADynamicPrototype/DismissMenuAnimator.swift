//
//  DismissMenuAnimator.swift
//  myAIDADynamicPrototype
//
//  Created by Lew Freyholtz on 02.08.17.
//  Copyright © 2017 Lew Freyholtz. All rights reserved.
//

import Foundation
import UIKit

class DismissMenuAnimator : NSObject {
    
    
    var transitionDuration = 0.4

    
}

extension DismissMenuAnimator:UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return transitionDuration
    }
    
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let duration = transitionDuration(using: transitionContext)
        let fromVC = transitionContext.viewController(forKey: .from)!
        let toVC = transitionContext.viewController(forKey: .to)!
        let containerView = transitionContext.containerView
        
        
        containerView.insertSubview(toVC.view, belowSubview: fromVC.view)
        let snapshot = containerView.viewWithTag(MenuHelper.snapshotNumber)
        
        
        if let snapshot = snapshot {
            
            
            UIView.animate(withDuration:duration, delay:0, usingSpringWithDamping:1.0, initialSpringVelocity:0.0, options: [], animations: {
                snapshot.frame = CGRect(origin: CGPoint.zero, size: UIScreen.main.bounds.size)
                
            }, completion: { (finished) in
                
                let didTransitionComplete = !transitionContext.transitionWasCancelled
                if didTransitionComplete {
                    containerView.insertSubview(toVC.view, aboveSubview: fromVC.view)
                    snapshot.removeFromSuperview()
                }

                transitionContext.completeTransition(didTransitionComplete)
            })
        }

    }
    
   
}
