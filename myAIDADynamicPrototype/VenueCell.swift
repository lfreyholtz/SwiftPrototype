//
//  VenueCell.swift
//  myAIDADynamicPrototype
//
//  Created by Lew Freyholtz on 05.07.17.
//  Copyright © 2017 Lew Freyholtz. All rights reserved.
//

import UIKit


class VenueCell: UICollectionViewCell {
    
    

    @IBOutlet weak var venueImage: UIImageView!
    @IBOutlet weak var heroGroup: UIView!
    
    @IBOutlet weak var venueInfo: VenueInfoView!
//    @IBOutlet weak var sepLine: LineBackgroundView!
    @IBOutlet weak var gradientView: GradientView!
    
//    @IBOutlet weak var venueName: AdvancedLabel!
//    @IBOutlet weak var venueSubtitle: UILabel!
//    
//    @IBOutlet weak var venueTypeDescriptor: UILabel!
//    
//    @IBOutlet weak var textInfo: UIStackView!
//    
//    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
//    @IBOutlet weak var leftConstraint: NSLayoutConstraint!
//    @IBOutlet weak var trailingConstraint: NSLayoutConstraint!
    
    var textGroupHeight:CGFloat = 0
    
    var selectedCell:Bool = false
    
//    var textGroupConstraintValue:CGFloat = 0 {
//        didSet {
//            bottomConstraint.constant = textGroupConstraintValue
//        }
//    }
//    

    var venue:Venue? {
        didSet {
            guard let venue = venue else { return }
            venueInfo.venue = venue
            let venueImages = venue.images
            let keyImage = venueImages.first
            let keyImageName = keyImage?.imageName

            if let keyImageName = keyImageName {

                venueImage.image = UIImage(named: keyImageName)


            } else {
                venueImage.image = #imageLiteral(resourceName: "Image_FPO")
            
            }
//            if let venue = venue {
//                
//                guard let name = venue.name else { return }
//                venueName.text = name.uppercased()
//                venueName.addTextSpacing()
//                venueSubtitle.text = venue.tagline
//                
//                // test Hero
//                
//                
//                
//                let venueImages = venue.images
//                let keyImage = venueImages.first
//                let keyImageName = keyImage?.imageName
//                
//                if let keyImageName = keyImageName {
//                    
//                    venueImage.image = UIImage(named: keyImageName)
//
//                    
//                } else {
//                    venueImage.image = #imageLiteral(resourceName: "Image_FPO")
//                
//                }
//                
//                let venueType = venue.type
//                let typeDescriptor = venueType?.typeDescription
//                                
//                if let typeDescriptor = typeDescriptor {
//                    
//                    venueTypeDescriptor.text = typeDescriptor
//                    
//                }
//
//            }
        }
    }
    

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.backgroundColor = UIColor.black
        if let venueInfo = venueInfo {
            venueInfo.venue = venue
        }
        
       
        

    }
    override func layoutIfNeeded() {
//        print("constraint size value at layoutIfNeeded:\(textGroupConstraintValue)")
    }
    
 
    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        
        super.apply(layoutAttributes)
        self.layoutIfNeeded()
        let standardHeight = PhotoListLayoutConstants.Cell.standardHeight
        let featuredHeight = PhotoListLayoutConstants.Cell.featuredHeight
        
        
        let transformMargin:CGFloat = 10
        let delta = 1 - ((featuredHeight - frame.height - transformMargin) / (featuredHeight - standardHeight))
        
        // alpha
        let minAlpha:CGFloat = 0.0
        let maxAlpha:CGFloat = 1.0
        let alphaMod = minAlpha - (delta * (minAlpha - maxAlpha))
        
//        venueInfo.venueNameLabel.alpha = alphaMod
//        venueInfo.descriptionLabel.alpha = alphaMod
//        venueInfo.subheadingLabel.alpha = alphaMod
        
        updateScrollEffects()

        
        

        
    }
    
    
    func updateScrollEffects() {
        
        
        // constraints
        let standardHeight = PhotoListLayoutConstants.Cell.standardHeight
        let featuredHeight = PhotoListLayoutConstants.Cell.featuredHeight
        let transformMargin:CGFloat = 10
        
        
//        textGroupHeight = venueTypeDescriptor.frame.maxY - venueSubtitle.frame.minY
//        let delta = 1 - ((featuredHeight - frame.height - transformMargin) / (featuredHeight - standardHeight))
//        
//        let featureConstraintSize:CGFloat = 24.0
//        let collapsedConstraintSize:CGFloat = textGroupHeight * -1
//        
//        let constraintMod = collapsedConstraintSize - (delta*(collapsedConstraintSize - featureConstraintSize))
//        textGroupConstraintValue = constraintMod

    }

}
