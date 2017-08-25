//
//  AdvancedLabel.swift
//  myAIDADynamicPrototype
//
//  Created by Lew Freyholtz on 11.07.17.
//  Copyright © 2017 Lew Freyholtz. All rights reserved.
//

import UIKit

class AdvancedLabel: UILabel {
    
    
    var textInsets = UIEdgeInsets.zero {
        didSet { invalidateIntrinsicContentSize() }
    }
    
    override func textRect(forBounds bounds: CGRect, limitedToNumberOfLines numberOfLines: Int) -> CGRect {
        let insetRect = UIEdgeInsetsInsetRect(bounds, textInsets)
        let textRect = super.textRect(forBounds: insetRect, limitedToNumberOfLines: numberOfLines)
        let invertedInsets = UIEdgeInsets(top: -textInsets.top,
                                          left: -textInsets.left,
                                          bottom: -textInsets.bottom,
                                          right: -textInsets.right)
        
        
        return UIEdgeInsetsInsetRect(textRect, invertedInsets)
    }
    
    override func drawText(in rect: CGRect) {
        super.drawText(in: UIEdgeInsetsInsetRect(rect, textInsets))
    }
}
extension AdvancedLabel {
    func addTextSpacing() {
        if let textString = text {
            
            let attributedString = NSMutableAttributedString(string: textString)
            let strLength = attributedString.length
            let paragraphStyle = NSMutableParagraphStyle()
            let font = self.font
            var adjustedTop = CGFloat(0)
            paragraphStyle.minimumLineHeight = 0
            paragraphStyle.maximumLineHeight = 0 //unlimited
            
            
            paragraphStyle.lineHeightMultiple = 0.85
            paragraphStyle.lineSpacing = 0
            
            
            
            attributedString.addAttribute(NSParagraphStyleAttributeName, value:paragraphStyle, range:NSMakeRange(0, strLength))
            attributedString.addAttribute(NSKernAttributeName, value: -1.0, range: NSMakeRange(0,strLength))
            
//            print("paragraph line height multiple: \(paragraphStyle.lineHeightMultiple)")
            if let font = font {
//                print("line height: \(font.lineHeight)")
                adjustedTop = ceil(font.lineHeight - paragraphStyle.lineHeightMultiple * font.lineHeight)
                
            }
            
            self.textInsets = UIEdgeInsets(top: adjustedTop, left: 0, bottom: 0, right: 0)
            self.frame.size.height += adjustedTop
            self.attributedText = attributedString
            
            
            
            //            self.sizeToFit()
            
        }
    }
    
    func setSpacing(value:Double) {
        if let textString = text {
            let attributedString = NSMutableAttributedString(string: textString)
            attributedString.addAttribute(NSKernAttributeName, value: value, range: NSRange(location: 0, length: attributedString.length))
            self.attributedText = attributedString
            
        }
    }
}
