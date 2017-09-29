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
    
    func modulate(input:CGFloat, x1:CGFloat, x2:CGFloat, y1:CGFloat, y2:CGFloat, limit:Bool) -> CGFloat {
        let result:CGFloat = (((input - x1) * (y2 - y1)) / (x2 - x1)) + y1
        if limit == true {
            if y1 < y2 {
                if result < y1 {
                    return y1
                    
                } else if result > y2 {
                    return y2
                }
            } else {
                if result > y1 {
                    return y1
                } else if result < y2 {
                    return y2
                }
            }
        }
        return result
        
    }


}
