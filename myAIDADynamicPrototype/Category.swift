//
//  Category.swift
//  myAIDADynamicPrototype
//
//  Created by Lew Freyholtz on 23.06.17.
//  Copyright © 2017 Lew Freyholtz. All rights reserved.
//

import Foundation
import RealmSwift

class Category : Object {

    dynamic var title = ""
    dynamic var memberType = ""
    dynamic var topic: Topic?
    
    
    
    
    dynamic var subtitle = ""
    dynamic var subsingle = ""
    
    let venueMembers = LinkingObjects(fromType: Venue.self, property: "categories")
    //TODO: other types
    
    
    
  
    
}
