//
//  CatalogDetailHeader.swift
//  myAIDADynamicPrototype
//
//  Created by LewFreyholtz on 10/31/17.
//  Copyright © 2017 Lew Freyholtz. All rights reserved.
//

import UIKit

@IBDesignable class VenueDetailHeader: UICollectionReusableView {
    
    
    @IBOutlet weak var venueDetail: VenueInfoView!
    static var identifier: String {
        return String(describing: self)
    }
    
    static var nib:UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    
//    var venue:VenueDetailInfoModelItem? {
//        
////        ...
//    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    

    
}
