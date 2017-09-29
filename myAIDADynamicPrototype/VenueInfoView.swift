//
//  VenueInfoView.swift
//  myAIDADynamicPrototype
//
//  Created by Lew Freyholtz on 23.08.17.
//  Copyright © 2017 Lew Freyholtz. All rights reserved.
//

import UIKit


@IBDesignable class VenueInfoView: UIView {
    

    @IBOutlet var contentView: UIView!

    @IBOutlet weak var divisionLine: LineBackgroundView!
    @IBOutlet weak var titleLabel: AdvancedLabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    
    @IBOutlet var infoStack: UIStackView!
    @IBOutlet weak var keyImage: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet var openingIcon: UIImageView!
    @IBOutlet var openingTimeLabel: UILabel!
    @IBOutlet var containerView: UIView!
    @IBOutlet weak var textAreaBottomConstraint: NSLayoutConstraint!
    @IBOutlet var containerViewBottom: NSLayoutConstraint!
    @IBOutlet var containerHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet var gradientOverlay: GradientView!
    // probably need to refactor this to decouple from constants in layout class
    let compactFrameHeight = PhotoListLayoutConstants.Cell.standardHeight
    let featureFrameHeight = PhotoListLayoutConstants.Cell.featuredHeight
    let fullScreenHeight = PhotoListLayoutConstants.Cell.fullScreenHeight
    
    
        var venue:Venue? {
        didSet {
            
            
            guard let venue = venue else { return }
            titleLabel.text = venue.name?.uppercased()
            titleLabel.addTextSpacing()
            guard let type = venue.type else { return }
            descriptionLabel.text = type.typeDescription
            subtitleLabel.text = venue.tagline
            
            let venueImages = venue.images
            let defaultImage = venueImages.first
            let keyImageName = defaultImage?.imageName
            
            if let keyImageName = keyImageName {
                
                keyImage.image = UIImage(named: keyImageName)
                
                
            } else {
                keyImage.image = #imageLiteral(resourceName: "Image_FPO")
                
            }

            
        }
       
            
            
        
    }
    
    override var bounds: CGRect {
        didSet {
            
            // needs to be called at the outset to get correct subview frames (https://stackoverflow.com/questions/28269452/subview-frame-is-incorrect-when-creating-uicollectionviewcell)
            
            self.layoutIfNeeded()
            
            // font size
            let frameHeight = self.bounds.height
            let minFontSize:CGFloat = 24.0
            let maxFontSize:CGFloat = 32.0
            let calculatedFontSize = Utils().modulate(input: frameHeight, x1: compactFrameHeight, x2: fullScreenHeight, y1: minFontSize, y2: maxFontSize, limit:false)

            self.titleLabel.font = self.titleLabel.font.withSize(calculatedFontSize)
            
            // bottom constraint
            
            let textGroupHeight = self.descriptionLabel.frame.maxY - (self.titleLabel.frame.maxY + 12)
            let featuredConstraintHeight:CGFloat = 24.0
            let collapsedConstraintHeight:CGFloat = (textGroupHeight * -1)
//            print(textGroupHeight)
            self.textAreaBottomConstraint.constant = Utils().modulate(input: frameHeight, x1: compactFrameHeight, x2: featureFrameHeight, y1: collapsedConstraintHeight, y2: featuredConstraintHeight, limit: true)
            
            // text alpha
            let textAlpha = Utils().modulate(input: frameHeight, x1: compactFrameHeight, x2: featureFrameHeight, y1: 0, y2: 1, limit:false)
            self.descriptionLabel.alpha = textAlpha
            self.subtitleLabel.alpha = textAlpha
            self.divisionLine.alpha = textAlpha
            
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
        
    }
    
    required init?(coder aDecoder:NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    override func layoutIfNeeded() {
        super.layoutIfNeeded()
    }
    
    
    private func commonInit() {
        let bundle:Bundle = Bundle(for: type(of: self))
        
        bundle.loadNibNamed("VenueInfoView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        contentView.layoutSubviews()
        contentView.updateConstraints()
  
    }
    
    // parallax and squish
    func scrollViewDidScroll(scrollView:UIScrollView) {
        
        let offsetY = -(scrollView.contentOffset.y)
//        print(offsetY)

        contentView.clipsToBounds = offsetY <= 0
        containerViewBottom.constant = offsetY >= 0 ? 0 : offsetY / 2
        containerHeightConstraint.constant = max(offsetY, 0) // maybe need to account for inset
        
        // make sure that the text doesn't drop below scrolling down, does not get covered scrolling up
        self.textAreaBottomConstraint.constant = offsetY >= 0 ? 24 + fabs(offsetY) : 24 + fabs(offsetY * 0.7)
        
//        print(textAreaBottomConstraint.constant)
        
        // text fade
        let fadeRangeStart:CGFloat = -100
        let fadeRangeEnd:CGFloat = -300
        
        let textAlpha = Utils().modulate(input: offsetY, x1: fadeRangeStart, x2: fadeRangeEnd, y1: 1, y2: 0, limit: false)
        self.infoStack.alpha = textAlpha
        
        
        // image fade
        let fadeAlpha = Utils().modulate(input:offsetY, x1:fadeRangeStart, x2:fadeRangeEnd, y1:1, y2:0.5, limit:true)
        
        self.gradientOverlay.alpha = fadeAlpha
        self.keyImage.alpha = fadeAlpha
        
    }

}
