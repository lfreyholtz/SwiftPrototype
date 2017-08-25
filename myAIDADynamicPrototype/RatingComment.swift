//
//  RatingComment.swift
//  myAIDADynamicPrototype
//
//  Created by Lew Freyholtz on 29.06.17.
//  Copyright © 2017 Lew Freyholtz. All rights reserved.
//

import Foundation
import RealmSwift


class RatingComment : Object {

    dynamic var commentText:String?
    dynamic var commentUser:User?
    let rating = RealmOptional<Int>()
    

}
