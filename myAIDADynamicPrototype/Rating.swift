//
//  Rating.swift
//  myAIDADynamicPrototype
//
//  Created by LewFreyholtz on 8/27/17.
//  Copyright © 2017 Lew Freyholtz. All rights reserved.
//

import Foundation
import RealmSwift



class Rating : Object {
    
    dynamic var ratingValue:Int = 0
    dynamic var comment:String?
    dynamic var user:User?
    dynamic var ratingDate:Date?
    
    
    
}
