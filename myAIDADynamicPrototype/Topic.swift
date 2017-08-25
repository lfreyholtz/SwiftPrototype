//
//  Topic.swift
//  myAIDADynamicPrototype
//
//  Created by Lew Freyholtz on 22.06.17.
//  Copyright © 2017 Lew Freyholtz. All rights reserved.
//

import Foundation
import RealmSwift


class Topic: Object {
    
    dynamic var title: String?
    dynamic var tagline: String?
    dynamic var topicImage: String?
    
    let hasPromotion = RealmOptional<Bool>()
    
//    private RealmList<Category> categories
    
    let categories = LinkingObjects(fromType:Category.self, property:"topic")
    
    
    
}
