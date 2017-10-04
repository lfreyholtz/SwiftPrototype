//
//  CatalogCoverViewModel.swift
//  myAIDADynamicPrototype
//
//  Created by LewFreyholtz on 10/4/17.
//  Copyright © 2017 Lew Freyholtz. All rights reserved.
//

import Foundation
import RealmSwift




class VenueCoverViewModel : NSObject {
    
    var venueName: String
    var tagline:String
    var venueType:String
    var typeDescription: String
    var keyImageName: String
    // for later
    //    var rating: CGFloat
    //    var totalRatings: Int
    //    var isOpen:Bool
    //    var occupancy:CGFloat
    //    var isFavorite:Bool
    //

    

    init(venueName:String, tagline:String, venueType:String, typeDescription:String, keyImageName:String) {
        
        self.venueName = venueName
        self.tagline = tagline
        self.venueType = venueType
        self.typeDescription = typeDescription
        self.keyImageName = keyImageName
    }

    
}
