//
//  LineBackgroundView.swift
//  myAIDADynamicPrototype
//
//  Created by Lew Freyholtz on 05.07.17.
//  Copyright © 2017 Lew Freyholtz. All rights reserved.
//

import UIKit

@IBDesignable class LineBackgroundView: UIView {

    
    override func layoutSubviews() {
        
        addDashedLine(strokeColor: UIColor.white, lineWidth: 1.0)
        
        
        
    }
    
    func addDashedLine(strokeColor: UIColor, lineWidth: CGFloat) {
        
        backgroundColor = .clear
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.name = "DashedTopLine"
        shapeLayer.bounds = bounds
        shapeLayer.position = CGPoint(x: frame.width / 2, y: frame.height / 2)
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = strokeColor.cgColor
        shapeLayer.lineWidth = lineWidth
        shapeLayer.lineJoin = kCALineJoinRound
        shapeLayer.lineDashPattern = [4, 4]
        
        let path = CGMutablePath()
        path.move(to: CGPoint.zero)
        path.addLine(to: CGPoint(x: frame.width, y: 0))
        shapeLayer.path = path
        
        layer.addSublayer(shapeLayer)
    }
}
