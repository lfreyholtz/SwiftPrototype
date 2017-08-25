//
//  ExpandableHeader.swift
//  myAIDADynamicPrototype
//
//  Created by Lew Freyholtz on 09.08.17.
//  Copyright © 2017 Lew Freyholtz. All rights reserved.
//

import UIKit


protocol ExpandableHeaderViewDelegate {
    func toggleSection(header:ExpandableHeader, section:Int)
}

private let headerKerningValue:CGFloat = 1.5
class ExpandableHeader: UITableViewHeaderFooterView {
    
    var delegate:ExpandableHeaderViewDelegate?
    var section:Int!
    
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var titleLabel: AdvancedLabel!
    @IBOutlet weak var disclosure: UIImageView!
    
    
    func customInit(title:String, section:Int, icon:UIImage, delegate:ExpandableHeaderViewDelegate) {
        self.titleLabel?.attributedText = setTextAttributes(ofString: title)
        self.section = section
        self.icon?.image = icon
        self.delegate = delegate
    }
    
 

    func selectHeaderAction(gestureRecognizer:UITapGestureRecognizer) {
        let cell = gestureRecognizer.view as! ExpandableHeader
        delegate?.toggleSection(header: self, section: cell.section)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(selectHeaderAction)))
    }

    func setTextAttributes(ofString:String) -> NSMutableAttributedString {
        let attributedString = NSMutableAttributedString(string:ofString)
        attributedString.addAttribute(NSKernAttributeName, value: headerKerningValue, range: NSRange(location: 0, length: attributedString.length - 1)) //subtract one from length to allow for centering if necessary
        return attributedString
    
    }
}


