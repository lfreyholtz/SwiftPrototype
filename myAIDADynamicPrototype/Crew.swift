//
//  Crew.swift
//  myAIDADynamicPrototype
//
//  Created by Lew Freyholtz on 29.06.17.
//  Copyright © 2017 Lew Freyholtz. All rights reserved.
//

import Foundation
import RealmSwift

class Crew : Object {
    
    
   
    dynamic var crewID = NSUUID().uuidString
    
    dynamic var user:User? = nil
    
    dynamic var jobTitle:String?
    

    //bio items

    //MARK: Meta
    
    override class func primaryKey() -> String? {
        return "crewID"
    }

}
