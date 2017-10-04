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
    @IBOutlet weak var gradientView: GradientView!
    

    
    var textGroupHeight:CGFloat = 0
    
    var selectedCell:Bool = false
    var viewModel:VenueCoverViewModel? {
        didSet {
            self.venueInfo.viewModel = viewModel
        }
    }
    


    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.backgroundColor = UIColor.black
        
    }

 
    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        super.apply(layoutAttributes)
        self.layoutIfNeeded()
        
    }
    
    
   
}
