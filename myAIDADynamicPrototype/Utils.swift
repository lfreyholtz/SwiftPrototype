//
//  Utils.swift
//  myAIDADynamicPrototype
//
//  Created by Lew Freyholtz on 23.08.17.
//  Copyright © 2017 Lew Freyholtz. All rights reserved.
//

import UIKit

class Utils: NSObject {

// TODO: Implement range limiting, use pattern matching y1...y2 ~= result
    
    func modulate(input:CGFloat, x1:CGFloat, x2:CGFloat, y1:CGFloat, y2:CGFloat) -> CGFloat {
        let result:CGFloat = (((input - x1) * (y2 - y1)) / (x2 - x1)) + y1
        
        return result
        
    }


}
