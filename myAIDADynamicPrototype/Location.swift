//
//  Location.swift
//  myAIDADynamicPrototype
//
//  Created by Lew Freyholtz on 29.06.17.
//  Copyright © 2017 Lew Freyholtz. All rights reserved.
//

import Foundation
import RealmSwift



class Location : Object {

    dynamic var locationTitle:String?
    dynamic var locationDeck:String?
    
    dynamic var locationDescription:String?
    dynamic var deckPlan:String? // stub for simple image representation
    //TODO: scrollposition storage for locating pin on deckplan
    //let coordinates = RealmOptional<Int>()
}
