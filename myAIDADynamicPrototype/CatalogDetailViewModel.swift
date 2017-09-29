//
//  CatalogDetailViewModel.swift
//  myAIDADynamicPrototype
//
//  Created by LewFreyholtz on 9/28/17.
//  Copyright © 2017 Lew Freyholtz. All rights reserved.
//

import Foundation
import RealmSwift




protocol CatalogDetailItem {
    var type: CatalogDetailItemType { get }
}

enum CatalogDetailItemType {
    case venue
    case excursion
    case event
    case shop
    
}

class venueDetail: CatalogDetailItem {
    var type: CatalogDetailItemType {
        return .venue
    }
}

// could use extension for defaults
