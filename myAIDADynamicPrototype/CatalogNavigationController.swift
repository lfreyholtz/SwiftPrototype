//
//  CatalogNavigationController.swift
//  myAIDADynamicPrototype
//
//  Created by LewFreyholtz on 9/19/17.
//  Copyright © 2017 Lew Freyholtz. All rights reserved.
//

import UIKit

class CatalogNavigationController: UINavigationController {
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavBarBackground()

        self.navigationBar.shadowImage = UIImage()
        self.navigationBar.isTranslucent = true
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
 
    func setNavBarBackground() {
        
        var updatedFrame = self.navigationBar.bounds
        updatedFrame.size.height += 20
        let gradientLayer = GradientView(frame:updatedFrame)

        gradientLayer.topColor = UIColor(hue: 0, saturation: 0, brightness: 0, alpha: 0.6)
        gradientLayer.topColorLocation = 0.0
        
        gradientLayer.midColor = UIColor(hue: 0, saturation: 0, brightness: 0, alpha: 0.3)
        gradientLayer.midColorLocation = 0.5
        
        gradientLayer.bottomColor = UIColor.clear
        gradientLayer.bottomColorLocation = 1.0
//        gradientLayer.gradientCenter = CGPoint(x: 24, y: 0)
//        gradientLayer.insideColor = UIColor(hue: 0, saturation: 0, brightness: 0, alpha: 0.8)
//        gradientLayer.outsideColor = UIColor.clear
//        gradientLayer.startRadius = self.navigationBar.frame.size.height
//        gradientLayer.endRadius = self.navigationBar.frame.height * 1.5

        let imageGradient = gradientLayer.createGradientImage()
        if let imageGradient = imageGradient {
            self.navigationBar.setBackgroundImage(imageGradient, for: .default)
            
        }
    }


    
}
