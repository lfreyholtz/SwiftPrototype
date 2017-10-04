//
//  LocationTableViewCell.swift
//  myAIDADynamicPrototype
//
//  Created by LewFreyholtz on 9/29/17.
//  Copyright © 2017 Lew Freyholtz. All rights reserved.
//

import UIKit

class LocationTableViewCell: UITableViewCell {

    @IBOutlet var deckPlanImage: UIImageView!
    @IBOutlet var locationName: UILabel!
    @IBOutlet var locationDescripton: UILabel!
    @IBOutlet var titleHeader: UIStackView!
    @IBOutlet var disclosureArrow: UIImageView!
    
    @IBOutlet var cellTitleLabel: AdvancedLabel!
    @IBOutlet weak var insetArrow: UIImageView!

    @IBOutlet weak var disclosureHeader: UIView!
    @IBOutlet weak var infoStack: UIStackView!
    
    
    static var identifier: String {
        return String(describing: self)
    }
    
    static var nib:UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    
    var location:VenueDetailModelItem? {
        didSet {
            
            guard let location = location as? VenueDetailModelLocationItem else { return }
            self.locationName.text = location.locName
            self.locationDescripton.text = location.locationTitle
            
//            let image = UIImage(named: location.locationImageName)
            let image = #imageLiteral(resourceName: "FPO_deckPlan")
            
            self.deckPlanImage.image = image
           
            
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        self.translatesAutoresizingMaskIntoConstraints = false
        
        // xcode bug on tint color (setting in XIB unreliable)
        insetArrow.tintColor = UIColor(red: CGFloat(85/255.0), green: CGFloat(85/255.0), blue: CGFloat(85/255.0), alpha: 1.0)
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
