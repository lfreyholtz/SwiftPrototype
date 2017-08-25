//
//  DetailCoverView.swift
//  myAIDADynamicPrototype
//
//  Created by Lew Freyholtz on 09.08.17.
//  Copyright © 2017 Lew Freyholtz. All rights reserved.
//

import UIKit

class VenueCoverView: UIView {


    @IBOutlet weak var venueTitle: AdvancedLabel!
    @IBOutlet weak var keyImage: UIImageView!
    @IBOutlet weak var keyImageGradient:GradientView!
    @IBOutlet weak var actionButton: UIButton!
    @IBOutlet weak var venueSubtitle: UILabel!
    @IBOutlet weak var venueTypeDescription: UILabel!
    
    @IBOutlet weak var containerView: UIView!
//    @IBOutlet weak var infoAndButtonBottomConstraint: NSLayoutConstraint!

    @IBOutlet weak var infoStack: UIStackView!
    
    // Constraints for parallax / squish
    @IBOutlet weak var heightLayoutConstraint: NSLayoutConstraint!
    @IBOutlet weak var bottomLayoutConstraint: NSLayoutConstraint!
    @IBOutlet weak var containerLayoutConstraint: NSLayoutConstraint!
    @IBOutlet weak var buttonHeightConstraint: NSLayoutConstraint!
    
    
    var isBookable = true
    
    var venue:Venue? {
        didSet {
            if let venue = venue {
                guard let name = venue.name else { return }
                let keyImageName = venue.images[0].imageName
                
                if let keyImageName = keyImageName {
                    keyImage.image = UIImage(named: keyImageName)

                }
                
                venueTitle.text = name
                venueSubtitle.text = venue.tagline
                
                let typeDescriptor = venue.type?.typeDescription
                
                if let typeDescriptor = typeDescriptor {
                    
                    venueTypeDescription.text = typeDescriptor
                    
                }
                
                let bookable = venue.isBookable.value
                if bookable != nil {
                    if (bookable == false) {
//                        print("Bookable value:\(bookable)")
                        buttonHeightConstraint.constant = 0
//                        infoAndButtonBottomConstraint.constant = 24
                        self.updateConstraints()
                    } else {
                        buttonHeightConstraint.constant = 48
//                        infoAndButtonBottomConstraint.constant = 0
                        actionButton.isHidden = true
                        self.updateConstraints()
                    }
                }



            }
        }
        
        // TODO: isOpen
        // TODO: popular times replacement (green, yellow, red dot)
        // TODO: isFavorite
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.frame.size = UIScreen.main.bounds.size
        layoutIfNeeded()
    }
    
    override func layoutSubviews() {

        
    }
    
    func scrollViewDidScroll(scrollView:UIScrollView) {
        containerLayoutConstraint.constant = scrollView.contentInset.top 
        let offsetY = -(scrollView.contentOffset.y + scrollView.contentInset.top)
        containerView.clipsToBounds = offsetY <= 0
        bottomLayoutConstraint.constant = offsetY >= 0 ? 0 : -offsetY / 2
        heightLayoutConstraint.constant = max(offsetY + scrollView.contentInset.top, scrollView.contentInset.top)

    }
    
}
