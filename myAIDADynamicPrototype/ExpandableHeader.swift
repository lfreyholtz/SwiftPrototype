//
//  ExpandableHeader.swift
//  myAIDADynamicPrototype
//
//  Created by Lew Freyholtz on 09.08.17.
//  Copyright © 2017 Lew Freyholtz. All rights reserved.
//

import UIKit


protocol ExpandableHeaderDelegate {
    func toggleSection(header:ExpandableHeader, section:Int)
}

private let headerKerningValue:CGFloat = 1.5


class ExpandableHeader: UITableViewHeaderFooterView {
    
    var delegate:ExpandableHeaderDelegate?
    var section:Int = 0
    
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var titleLabel: AdvancedLabel!
    @IBOutlet weak var disclosure: UIImageView!
    @IBOutlet weak var tempSep: UIView!
    
    
    var item:VenueDetailModelItem? {
        didSet {
            guard let item = item else { return }
            
            let sectionTitle = item.sectionTitle
            titleLabel.attributedText = setTextAttributes(ofString: sectionTitle)
            setCollapsed(collapsed: item.isCollapsed)
            icon.image = UIImage(named: item.sectionIconName)
            
        }
    }

    static var identifier: String {
        return String(describing: self)
    }
    
    static var nib:UINib {
        return UINib(nibName: identifier, bundle: nil)
    }


    

    func didTapHeader(gestureRecognizer:UITapGestureRecognizer) {
        
        delegate?.toggleSection(header: self, section: section)
    }

    func setCollapsed(collapsed: Bool) {
        tempSep.isHidden = !collapsed

        disclosure?.rotate(collapsed ? 0.0 : .pi)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapHeader)))
        tempSep.alpha = 1.0
    }

    func setTextAttributes(ofString:String) -> NSMutableAttributedString {
        let attributedString = NSMutableAttributedString(string:ofString)
        attributedString.addAttribute(NSKernAttributeName, value: headerKerningValue, range: NSRange(location: 0, length: attributedString.length - 1)) //subtract one from length to allow for centering if necessary
        return attributedString
    
    }
}



extension UIView {
    
    
    func rotate(_ toValue:CGFloat, duration:CFTimeInterval = 0.2) {
        let animation = CABasicAnimation(keyPath:"transform.rotation")
        animation.toValue = toValue
        animation.duration = duration
        animation.isRemovedOnCompletion = false
        animation.fillMode = kCAFillModeForwards
        self.layer.add(animation, forKey:nil)
        
    }
}
