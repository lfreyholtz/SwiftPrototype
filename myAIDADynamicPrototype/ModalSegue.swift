//
//  ModalSegue.swift
//  myAIDADynamicPrototype
//
//  Created by Lew Freyholtz on 23.06.17.
//  Copyright © 2017 Lew Freyholtz. All rights reserved.
//

import UIKit

class ModalSegue: UIStoryboardSegue {
    
    override func perform() {
        let firstVCView = self.source.view as UIView!
        let secondVCView = self.destination.view as UIView!
        
        let screenWidth = UIScreen.main.bounds.size.width
        let screenHeight = UIScreen.main.bounds.size.height
        
        
        secondVCView?.frame = CGRect(x: 0.0, y: screenHeight, width: screenWidth, height: screenHeight)
        
        
        let window = UIApplication.shared.keyWindow
        window?.insertSubview(secondVCView!, aboveSubview: firstVCView!)
        
        
        UIView.animate(
            withDuration: 0.4,
            animations: {
                    firstVCView!.frame = firstVCView!.frame.offsetBy(dx: 0.0, dy: -screenHeight)
                    secondVCView!.frame = secondVCView!.frame.offsetBy(dx: 0.0, dy: -screenHeight)
        },
            completion: {
                (Finished) -> Void in
                    self.source.present(self.destination as UIViewController,
                                    animated: false,
                                    completion: nil)
        })
    }
}
