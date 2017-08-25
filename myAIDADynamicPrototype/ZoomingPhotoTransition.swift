//
//  ZoomAnimatorPush.swift
//  myAIDADynamicPrototype
//
//  Created by Lew Freyholtz on 14.08.17.
//  Copyright © 2017 Lew Freyholtz. All rights reserved.
//

import Foundation
import UIKit




protocol ZoomingPhotoController {
    func heroImage(for transition:ZoomingPhotoTransition) -> UIImageView?
    func gradient(for transition:ZoomingPhotoTransition) -> GradientView?
    func infoPanel(for transition:ZoomingPhotoTransition) -> UIView?
}


enum TransitionState {
        case initial
        case final
}




class ZoomingPhotoTransition : NSObject {
    
    var duration = 0.3
    var operation:UINavigationControllerOperation = .none
    

    
    //vars holding snapshots from views

    var fromViewController: UIViewController!
    var toViewController: UIViewController!
    
    typealias TransitionViews = (heroImage:UIImageView, gradient:UIView, bottomSnapshot:UIView, textPanel:UIView) //, textPanel:UIView
    
    func configureViewsForState(state:TransitionState, backgroundViewController:UIViewController, transitionImages:TransitionViews, keyImageOriginFrame:CGRect, keyImageTargetFrame:CGRect, infoPanelOriginFrame:CGRect, infoPanelTargetFrame:CGRect) {
        
        switch state {
            case .initial:
                // setup initial state
            transitionImages.heroImage.frame = keyImageOriginFrame
            transitionImages.gradient.frame = keyImageOriginFrame
            transitionImages.bottomSnapshot.frame = CGRect(x:0, y:keyImageOriginFrame.maxY, width:keyImageOriginFrame.width, height:backgroundViewController.view.frame.height - keyImageTargetFrame.maxY)
            transitionImages.textPanel.frame = infoPanelOriginFrame
            
            
            // main key image views in container view
            // container view frame to origin frame
            // list snapshot
            
            case .final:
                // setup final state
            transitionImages.heroImage.frame = keyImageTargetFrame
            transitionImages.gradient.frame = keyImageTargetFrame
            transitionImages.bottomSnapshot.frame = CGRect(x:0, y:keyImageTargetFrame.maxY, width:keyImageTargetFrame.width, height:backgroundViewController.view.frame.height - keyImageTargetFrame.maxY)
            transitionImages.textPanel.frame = infoPanelTargetFrame
        }
    }
    
 }

extension ZoomingPhotoTransition : UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        
        
        
        
        // references
        
        let duration = transitionDuration(using: transitionContext)
        let fromViewController = transitionContext.viewController(forKey: .from)!
        let toViewController = transitionContext.viewController(forKey: .to)!
        
        let containerView = transitionContext.containerView
        
        var backgroundViewController = fromViewController
        var foregroundViewController = toViewController
        
        var listBottomSnapshot:UIView!

        
        
    
        
        // states
        var preTransitionState = TransitionState.initial
        var postTransitionState = TransitionState.final
        
        if operation == .pop {
            backgroundViewController = toViewController
            foregroundViewController = fromViewController
            preTransitionState = TransitionState.final
            postTransitionState = TransitionState.initial
        }
    
        
        
        
        
        // view controller views
        containerView.addSubview(backgroundViewController.view)
        containerView.addSubview(foregroundViewController.view)
        
        containerView.backgroundColor = UIColor.clear
        
        
        
        // key image views
        let candidateBackgroundHeroImage = (backgroundViewController as? ZoomingPhotoController)?.heroImage(for: self)
        let candidateForegroundHeroImage = (foregroundViewController as? ZoomingPhotoController)?.heroImage(for: self)

        // check each view for existence
        assert(candidateBackgroundHeroImage != nil, "key image view could not be retrieved from background view controller")
        let backgroundKeyImage = candidateBackgroundHeroImage!
        
        assert(candidateForegroundHeroImage != nil, "key image view could not be retrieved from foreground view controller")
        let foregroundKeyImage = candidateForegroundHeroImage!
        
        let candidateBackgroundGradientView = (backgroundViewController as? ZoomingPhotoController)?.gradient(for: self)
        assert(candidateBackgroundGradientView != nil, "gradient view could not be retrieved from background view controller")
        
        let backgroundGradientView = candidateBackgroundGradientView!

        let candidateBackgroundInfoPanel = (backgroundViewController as? ZoomingPhotoController)?.infoPanel(for: self)
        assert(candidateBackgroundInfoPanel != nil, "Could not get info panel from background view controller")
        
        let candidateForegroundInfoPanel = (foregroundViewController as? ZoomingPhotoController)?.infoPanel(for: self)
        assert(candidateForegroundHeroImage != nil, "Could not retrive info panel from foreground image")
        
        let foregroundInfoPanel = candidateForegroundInfoPanel!
        let backgroundInfoPanel = candidateBackgroundInfoPanel!
        
        
        // hide returned transition views
        backgroundKeyImage.isHidden = true
        foregroundKeyImage.isHidden = true
        
        // frames
        let keyImageOriginFrame:CGRect = foregroundKeyImage.frame
        let keyImageTargetFrame:CGRect = backgroundKeyImage.frame
        
        
        /// TRANSITION IMAGES /////
        // key image snapshot
        let keyImageSnapshot = UIImageView(image: backgroundKeyImage.image)
        keyImageSnapshot.contentMode = .scaleAspectFill
        keyImageSnapshot.layer.masksToBounds = true
        containerView.addSubview(keyImageSnapshot)
        
        
        
        // gradient view
       
        let gradientSnapshot = GradientView(frame: keyImageSnapshot.frame)

        gradientSnapshot.topColor = backgroundGradientView.topColor
        gradientSnapshot.topColorLocation = backgroundGradientView.topColorLocation
        gradientSnapshot.midColor = backgroundGradientView.midColor
        gradientSnapshot.midColorLocation = backgroundGradientView.midColorLocation
        gradientSnapshot.bottomColor = backgroundGradientView.bottomColor
        gradientSnapshot.bottomColorLocation = backgroundGradientView.bottomColorLocation
        
        
        containerView.addSubview(gradientSnapshot)
        
        
        // text info stack view
       
        
        let foregroundInfoSnapshot:UIView = foregroundInfoPanel.snapshotView(afterScreenUpdates: true)!
        let backgroundInfoSnapshot:UIView = backgroundInfoPanel.snapshotView(afterScreenUpdates: true)!
        containerView.addSubview(foregroundInfoSnapshot)
        containerView.addSubview(backgroundInfoSnapshot)
        let infoPanelOriginFrame:CGRect = backgroundInfoPanel.frame
        let infoPanelTargetFrame:CGRect = foregroundInfoPanel.frame
        


        
        
        
       
        
        
        
        
        
        // remaining collectionViewCells
        guard let view = backgroundViewController.view else { return }
        let width = view.bounds.width
        let height = view.bounds.height
        
        let snapshotRect = CGRect(x:0, y:keyImageTargetFrame.maxY, width:width, height:height - keyImageTargetFrame.maxY)

        listBottomSnapshot = view.resizableSnapshotView(from: snapshotRect, afterScreenUpdates: false, withCapInsets: UIEdgeInsets.zero)
        if let listBottomSnapshot = listBottomSnapshot {
             containerView.addSubview(listBottomSnapshot)
        } else {
            print("Snapshot not created")
        }
        
       
        
        
        

        

   
        
        // first state configuration
        configureViewsForState(
            state: preTransitionState,
            backgroundViewController: backgroundViewController,
            transitionImages: (keyImageSnapshot, gradientSnapshot, listBottomSnapshot, backgroundInfoSnapshot),
            keyImageOriginFrame: keyImageOriginFrame,
            keyImageTargetFrame: keyImageTargetFrame,
            infoPanelOriginFrame: infoPanelOriginFrame,
            infoPanelTargetFrame: infoPanelTargetFrame)
        
        

        foregroundViewController.view.layoutIfNeeded()
        
        // animate
        UIView.animate(withDuration: duration, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: [.allowAnimatedContent, .curveEaseInOut], animations: {
        

            self.configureViewsForState(
                state: postTransitionState,
                backgroundViewController: backgroundViewController,
                transitionImages: (keyImageSnapshot, gradientSnapshot, listBottomSnapshot, backgroundInfoSnapshot),
                keyImageOriginFrame: keyImageOriginFrame,
                keyImageTargetFrame: keyImageTargetFrame,
                infoPanelOriginFrame: infoPanelOriginFrame,
                infoPanelTargetFrame: infoPanelTargetFrame)

        },
            completion: {(finished) in
                // clean up views
                
                keyImageSnapshot.removeFromSuperview()
                gradientSnapshot.removeFromSuperview()
                backgroundInfoSnapshot.removeFromSuperview()
                foregroundInfoSnapshot.removeFromSuperview()
                listBottomSnapshot.removeFromSuperview()
                
                
                foregroundKeyImage.isHidden = false
                backgroundKeyImage.isHidden = false
                
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            })
        
        
   

        
    }
    
    

   
}


extension ZoomingPhotoTransition : UINavigationControllerDelegate {
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        if fromVC is ZoomingPhotoController && toVC is ZoomingPhotoController {
            self.operation = operation
            return self
        } else {
            return nil
        }
    }
}


