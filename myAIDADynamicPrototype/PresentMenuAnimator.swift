//
//  PresentMenuAnimator.swift
//  myAIDADynamicPrototype
//
//  Created by Lew Freyholtz on 02.08.17.
//  Copyright © 2017 Lew Freyholtz. All rights reserved.
//

import UIKit


//class PresentMenuAnimator : NSObject {
//    var transitionDuration = 0.4
//}
//
//extension PresentMenuAnimator : UIViewControllerAnimatedTransitioning {
//    
//    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
//        return transitionDuration
//    }
//
//    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
//        
//        let duration = transitionDuration(using: transitionContext)
//        let fromVC = transitionContext.viewController(forKey: .from)!
//        let toVC = transitionContext.viewController(forKey: .to)!
//        let containerView = transitionContext.containerView
//        
// 
//        containerView.insertSubview(toVC.view, belowSubview: fromVC.view)
//        let snapshot = fromVC.view.snapshotView(afterScreenUpdates: false)
//        if let snapshot = snapshot {
//            snapshot.tag = MenuHelper.snapshotNumber
//            snapshot.isUserInteractionEnabled = false
//            snapshot.layer.shadowOpacity = 0.7
//            containerView.insertSubview(snapshot, aboveSubview: toVC.view)
//            fromVC.view.isHidden = true
//
//            
//            UIView.animate(withDuration: duration, animations: {
//                snapshot.center.x += UIScreen.main.bounds.width * MenuHelper.menuWidth
//                
//            }, completion: { (finished) in
//            
//                fromVC.view.isHidden = false
//                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
//            })
//        }
//        
//       
//
//    }
//}
class PresentMenuAnimator : NSObject {
}

extension PresentMenuAnimator : UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.6
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let duration = transitionDuration(using: transitionContext)

        
        guard
            let fromVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from),
            let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)
            else {
                return
        }
        let containerView = transitionContext.containerView
        containerView.insertSubview(toVC.view, belowSubview: fromVC.view)
        
        // replace main view with snapshot
        if let snapshot = fromVC.view.snapshotView(afterScreenUpdates: false) {
            snapshot.tag = MenuHelper.snapshotNumber
            snapshot.isUserInteractionEnabled = false
            snapshot.layer.shadowOpacity = 0.7
            
            containerView.insertSubview(snapshot, aboveSubview: toVC.view)
            fromVC.view.isHidden = true
            UIView.animate(withDuration:duration, delay:0, usingSpringWithDamping:1.0, initialSpringVelocity:0.0, options: [], animations: {
                    snapshot.center.x += UIScreen.main.bounds.width * MenuHelper.menuWidth
            },
                completion: { _ in
                    fromVC.view.isHidden = false
                    transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            }
            )
        }
    }
}
