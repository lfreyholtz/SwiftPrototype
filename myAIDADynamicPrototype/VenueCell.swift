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
    
    static var identifier: String {
        return String(describing: self)
    }
    
    static var nib:UINib {
        return UINib(nibName: identifier, bundle: nil)
    }

    
    var textGroupHeight:CGFloat = 0
    
    var selectedCell:Bool = false
    var infoViewModel:VenueCoverViewModel?
    
    var cellViewModel:PhotoListModelItem? {
        didSet {
            guard let cellViewModel = cellViewModel as? PhotoListModelVenueItem else { return }
            
            self.venueInfo.viewModel = cellViewModel.coverViewModel
//            venueInfo.layoutIfNeeded() // no effect
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
