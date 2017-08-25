//
//  Utils.swift
//  myAIDADynamicPrototype
//
//  Created by Lew Freyholtz on 23.08.17.
//  Copyright © 2017 Lew Freyholtz. All rights reserved.
//

import UIKit

class Utils: NSObject {

    static func modulate(value:CGFloat, fromLow:CGFloat, fromHigh:CGFloat, toLow:CGFloat, toHigh:CGFloat, limit:Bool) -> CGFloat {
        
        let result:CGFloat = (((value - fromLow) / (fromHigh - fromLow)) * (toHigh - toLow))
        
        if limit {
            if toLow < toHigh {
                if (result < toLow) { return toLow }
                if (result > toHigh) { return toHigh }
                
            } else {

                if (result > toLow) { return toLow }

                if (result < toHigh) { return toHigh }
            }
        }
        
        return result
        
    }
        


}
