//
//  ZoomPopTransition.swift
//  myAIDADynamicPrototype
//
//  Created by Lew Freyholtz on 15.08.17.
//  Copyright © 2017 Lew Freyholtz. All rights reserved.
//

import Foundation
import UIKit



class ZoomPopTransition : NSObject, UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        print("set duration")
        return 0
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
    }
    
}

