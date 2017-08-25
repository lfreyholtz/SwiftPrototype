//
//  GradientView.swift
//  myAIDADynamicPrototype
//
//  Created by Lew Freyholtz on 05.07.17.
//  Copyright © 2017 Lew Freyholtz. All rights reserved.
//

import UIKit

@IBDesignable class GradientView: UIView {
    
    @IBInspectable var gradientStart = CGPoint(x: 0.0, y: 0.0)
    @IBInspectable var gradientEnd = CGPoint(x:0.0, y:1.0)
    
    
    @IBInspectable var topColor: UIColor = UIColor.clear
    @IBInspectable var topColorLocation: Float = 0.0
    
    
    @IBInspectable var midColor: UIColor = UIColor.clear
    @IBInspectable var midColorLocation:Float = 0.5
    
    @IBInspectable var bottomColor: UIColor = UIColor(white: 0.0, alpha: 0.75)
    @IBInspectable var bottomColorLocation:Float = 1.0
    
    
    override class var layerClass: AnyClass {
        return CAGradientLayer.self
        
    }
    
    override func layoutSubviews() {
        
        (layer as! CAGradientLayer).colors = [topColor.cgColor, midColor.cgColor, bottomColor.cgColor]
        
        let newTopColorLoc = NSNumber(value: topColorLocation)
        let newMidColorLoc = NSNumber(value: midColorLocation)
        let newBotColorLoc = NSNumber(value:bottomColorLocation)
        
        (layer as! CAGradientLayer).locations = [newTopColorLoc, newMidColorLoc, newBotColorLoc]
        
        
    }

    
}
