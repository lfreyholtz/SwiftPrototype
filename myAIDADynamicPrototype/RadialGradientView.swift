//
//  RadialGradientView.swift
//  myAIDADynamicPrototype
//
//  Created by LewFreyholtz on 9/20/17.
//  Copyright © 2017 Lew Freyholtz. All rights reserved.
//

import UIKit

@IBDesignable

class RadialGradientView: UIView {

    @IBInspectable var insideColor: UIColor = UIColor.clear
    @IBInspectable var outsideColor: UIColor = UIColor.clear
    @IBInspectable var gradientCenter: CGPoint = CGPoint.zero
    @IBInspectable var startRadius: CGFloat = 0.0
    @IBInspectable var endRadius:CGFloat = 40.0
    override func draw(_ rect: CGRect) {
        let colors = [insideColor.cgColor, outsideColor.cgColor] as CFArray
        let endRadius = min(bounds.width, bounds.height) / 2
        let gradient = CGGradient(colorsSpace: nil, colors: colors, locations: nil)
        
        UIGraphicsGetCurrentContext()!.drawRadialGradient(gradient!, startCenter: gradientCenter, startRadius: startRadius, endCenter: gradientCenter, endRadius: endRadius, options:CGGradientDrawingOptions.drawsAfterEndLocation)
        
    }
    
    func createRadialGradientImage() -> UIImage? {
        
        let colors = [insideColor.cgColor, outsideColor.cgColor] as CFArray

        let gradient = CGGradient(colorsSpace: nil, colors: colors, locations: nil)
        
        UIGraphicsBeginImageContext(bounds.size)
        UIGraphicsGetCurrentContext()!.drawRadialGradient(gradient!, startCenter: gradientCenter, startRadius: 0, endCenter: gradientCenter, endRadius: endRadius, options:CGGradientDrawingOptions.drawsAfterEndLocation)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image
    }

}
