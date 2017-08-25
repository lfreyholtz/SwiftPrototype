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
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    
        var venue:Venue? {
        didSet {
            
            
            guard let venue = venue else { return }
            print("Setting view variables with venue \(venue.name)")
            titleLabel.text = venue.name?.uppercased()
            guard let type = venue.type else { return }
            descriptionLabel.text = type.typeDescription
            subtitleLabel.text = venue.tagline
            
           

        }
       
            
            
        
    }
    
    override var bounds: CGRect {
        didSet {
//            print("Height (from bounds) is: \(self.bounds.height)")
            let frameHeight = self.bounds.height
            let minFrameHeight:CGFloat = 100.0
            let maxFrameHeight:CGFloat = UIScreen.main.bounds.height
            let minFontSize:CGFloat = 18.0
            let maxFontSize:CGFloat = 28.0
            
            let calculatedFontSize = calculateFontSize(input: frameHeight, x1: minFrameHeight, x2: maxFrameHeight, y1: minFontSize, y2: maxFontSize)
            
            print(calculatedFontSize)

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
//    override func layoutSubviews() {
//        print("Height is \(self.contentView.frame.height)")
//    }
    private func commonInit() {
        let bundle:Bundle = Bundle(for: type(of: self))
        
//        Bundle.main.loadNibNamed("VenueInfoView", owner: self, options: nil)
        bundle.loadNibNamed("VenueInfoView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
    }
    
    func calculateFontSize(input:CGFloat, x1:CGFloat, x2:CGFloat, y1:CGFloat, y2:CGFloat) -> CGFloat {
        return (((input - x1) * (y2 - y1)) / (x2 - x1)) + y1
        
        
    }
}
