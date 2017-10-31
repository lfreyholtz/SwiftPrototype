//
//  DateExtensions.swift
//  myAIDADynamicPrototype
//
//  Created by LewFreyholtz on 10/5/17.
//  Copyright © 2017 Lew Freyholtz. All rights reserved.
//

import Foundation
//import AFDateHelper

extension Date {
    
    var yearsFromNow:   Int { return Calendar.current.dateComponents([.year],       from: self, to: Date()).year        ?? 0 }
    var monthsFromNow:  Int { return Calendar.current.dateComponents([.month],      from: self, to: Date()).month       ?? 0 }
    var weeksFromNow:   Int { return Calendar.current.dateComponents([.weekOfYear], from: self, to: Date()).weekOfYear  ?? 0 }
    var daysFromNow:    Int { return Calendar.current.dateComponents([.day],        from: self, to: Date()).day         ?? 0 }
    var hoursFromNow:   Int { return Calendar.current.dateComponents([.hour],       from: self, to: Date()).hour        ?? 0 }
    var minutesFromNow: Int { return Calendar.current.dateComponents([.minute],     from: self, to: Date()).minute      ?? 0 }
    var secondsFromNow: Int { return Calendar.current.dateComponents([.second],     from: self, to: Date()).second      ?? 0 }
    
    
    var relativeTime: String {
        if yearsFromNow   > 0 {
            return "\(yearsFromNow) year"    + (yearsFromNow    > 1 ? "s" : "") + " ago"
        }
        
        if monthsFromNow  > 0 { return "\(monthsFromNow) month"  + (monthsFromNow   > 1 ? "s" : "") + " ago" }
        if weeksFromNow   > 0 { return "\(weeksFromNow) week"    + (weeksFromNow    > 1 ? "s" : "") + " ago" }
        if daysFromNow    > 0 { return daysFromNow == 1 ? "Yesterday" : "\(daysFromNow) days ago" }
        if hoursFromNow   > 0 { return "\(hoursFromNow) hour"     + (hoursFromNow   > 1 ? "s" : "") + " ago" }
        if minutesFromNow > 0 { return "\(minutesFromNow) minute" + (minutesFromNow > 1 ? "s" : "") + " ago" }
        if secondsFromNow > 0 { return secondsFromNow < 15 ? "Just now"
            : "\(secondsFromNow) second" + (secondsFromNow > 1 ? "s" : "") + " ago" }
        return ""
    }
    
    
    func isBetween(beginDate:Date, endDate:Date, inclusive:Bool) -> Bool {

        if inclusive {
            return self.compare(beginDate) == .orderedDescending && self.compare(endDate) == .orderedAscending || self.compare(beginDate) == .orderedSame || self.compare(endDate) == .orderedSame
        } else {
            return self.compare(beginDate) == .orderedDescending && self.compare(endDate) == .orderedAscending
        }
        
        
    }
    

        
}


