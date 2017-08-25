//
//  User.swift
//  myAIDADynamicPrototype
//
//  Created by Lew Freyholtz on 29.06.17.
//  Copyright © 2017 Lew Freyholtz. All rights reserved.
//

import Foundation
import RealmSwift


class User: Object {
    
    
    dynamic var userID = NSUUID().uuidString

    dynamic var screenName:String?
    dynamic var avatarPic:String?
    
    
    

    //MARK: Meta
    
    override class func primaryKey() -> String? {
        return "userID"
    }
}
