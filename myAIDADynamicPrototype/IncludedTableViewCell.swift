//
//  IncludedTableViewCell.swift
//  myAIDADynamicPrototype
//
//  Created by LewFreyholtz on 10/4/17.
//  Copyright © 2017 Lew Freyholtz. All rights reserved.
//

import UIKit

class IncludedTableViewCell: UITableViewCell {

    @IBOutlet weak var includedLabel: UILabel!
    @IBOutlet weak var excludedLabel: UILabel!
    
    static var identifier: String {
        return String(describing: self)
    }
    
    static var nib:UINib {
        return UINib(nibName: identifier, bundle: nil)
    }

    
    var included:VenueDetailModelItem? {
        didSet {
            guard let included = included as? VenueDetailIncludedItem else { return }
            let formattedIncluded = NSMutableAttributedString()
            let formattedExcluded = NSMutableAttributedString()
            
            formattedIncluded
                .bold("Inclusiv: ")
                .normal(included.includedItems)
            self.includedLabel.attributedText = formattedIncluded

            
            formattedExcluded
                .bold("Aufpreis: ")
                .normal(included.excludedItems)
            self.excludedLabel.attributedText = formattedExcluded
            
            self.includedLabel.textColor = UIColor(red: CGFloat(85/255.0), green: CGFloat(85/255.0), blue: CGFloat(85/255.0), alpha: 1.0)

            self.excludedLabel.textColor = UIColor(red: CGFloat(85/255.0), green: CGFloat(85/255.0), blue: CGFloat(85/255.0), alpha: 1.0)
            
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
}

extension NSMutableAttributedString {
    @discardableResult func bold(_ text:String) -> NSMutableAttributedString {
        let attrs:[String:AnyObject] = [NSFontAttributeName : UIFont(name: "OpenSans-Bold", size: 16)!]
        let boldString = NSMutableAttributedString(string:"\(text)", attributes:attrs)
        self.append(boldString)
        return self
    }
    
    @discardableResult func normal(_ text:String)->NSMutableAttributedString {
        let normal =  NSAttributedString(string: text)
        self.append(normal)
        return self
    }
}
