//
//  DetailSection.swift
//  myAIDADynamicPrototype
//
//  Created by Lew Freyholtz on 09.08.17.
//  Copyright © 2017 Lew Freyholtz. All rights reserved.
//

import Foundation
import UIKit

struct DetailSection {
    var title:String!
    var icon:UIImage?
    var expanded:Bool!
    var type:String
    
    init(title:String, icon:UIImage, type:String, expanded:Bool ) {
        self.title = title
        self.icon = icon
        self.expanded = expanded
        self.type = type
    }
}
