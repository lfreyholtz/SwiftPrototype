//
//  VenueMenuItems.swift
//  myAIDADynamicPrototype
//
//  Created by Lew Freyholtz on 29.06.17.
//  Copyright © 2017 Lew Freyholtz. All rights reserved.
//

import Foundation
import RealmSwift


class VenueMenuItem:Object {
    
    dynamic var itemName:String?
    dynamic var itemDescription:String?
    let itemPrice = RealmOptional<Int>()


}
