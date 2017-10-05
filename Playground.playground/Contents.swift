//: Playground - noun: a place where people can play

import UIKit
import RealmSwift




let startTime:String = "2017-08-27 09:30:00"
let endTime:String = "2017-08-27 11:30:00"

//let currentTime:String = "2017-08-27 11:29:00"
let currentTime:String = "2017-08-27 11:30:00"

let fullDateFormatter = DateFormatter()
let dayOnlyFormatter = DateFormatter()
fullDateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss 'UTC+02:00'"
dayOnlyFormatter.dateFormat = "EEEE"

//dateFormatter.timeZone = TimeZone(abbreviation: "UTC")

let startTD = fullDateFormatter.date(from: startTime)
let endTD = fullDateFormatter.date(from: endTime)

let todayDT = fullDateFormatter.date(from: currentTime)
let unitFlags = Set<Calendar.Component>([.hour, .year, .minute, .day, .month, .weekday])
let calendar = Calendar.current

//let rightNow = calendar.dateComponents(unitFlags, from:todayDT as! Date)
//let openingTime = calendar.dateComponents(unitFlags, from: startTD as! Date)
//let closingTime = calendar.dateComponents(unitFlags, from: endTD as! Date)

//let currentDay = rightNow.weekday
let shortFormatter = CFDateFormatterStyle.fullStyle

let datePrint = dayOnlyFormatter.string(from: todayDT!)






    
func dateIsBetween(compareDate:Date, beginDate:Date, endDate:Date, inclusive:Bool) -> Bool {
    
    
    print("date: \(compareDate)")
    print("is between: \(beginDate) and \(endDate)")
    
    if inclusive {
        return compareDate.compare(beginDate) == .orderedDescending && compareDate.compare(endDate) == .orderedAscending ||
            compareDate.compare(beginDate) == .orderedSame || compareDate.compare(endDate) == .orderedSame
    } else {
        return compareDate.compare(beginDate) == .orderedDescending && compareDate.compare(endDate) == .orderedAscending
    }
    
    
}




let isOpen = dateIsBetween(compareDate: todayDT!, beginDate: startTD!, endDate: endTD!, inclusive: false)
let otherIsOpen = todayDT?.compare(startTD!) == ComparisonResult.orderedAscending && todayDT?.compare(endTD!) == ComparisonResult.orderedDescending

// if today > start date && < end date should be true


