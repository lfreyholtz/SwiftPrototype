//
//  DateExtensions.swift
//  myAIDADynamicPrototype
//
//  Created by LewFreyholtz on 10/5/17.
//  Copyright © 2017 Lew Freyholtz. All rights reserved.
//

import Foundation
import AFDateHelper

extension Date {
    
    func isBetween(beginDate:Date, endDate:Date, inclusive:Bool) -> Bool {
        
        


        if inclusive {
            return self.compare(beginDate) == .orderedDescending && self.compare(endDate) == .orderedAscending || self.compare(beginDate) == .orderedSame || self.compare(endDate) == .orderedSame
//            return self.compare(.isEarlier(than: endDate)) && self.compare(.isLater(than: beginDate)) || self.compare(beginDate) == .orderedSame || self.compare(endDate) == .orderedSame
        } else {
            return self.compare(beginDate) == .orderedDescending && self.compare(endDate) == .orderedAscending
//            return self.compare(.isEarlier(than: endDate)) && self.compare(.isLater(than:beginDate))
        }
        
        
    }
    

        
}


