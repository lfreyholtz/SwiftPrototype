//: Playground - noun: a place where people can play

import UIKit
//import RealmSwift





// get now



//var timer = Timer()






// to make string dynamic, need to create a timer that runs every second






//// generate new time zone transformed dates
//let timezoneTransformedOpening = calendar.date(from: openingTimeZoneComponents)
//let timezoneTransformedClosing = calendar.date(from: closingTimeZoneComponents)
// convert now into new date in UTC
//let adjustedNow = calendar.dateComponents(in: UTCTimeZone, from: now)
//let adjustedNowString = calendar.date(from: adjustedNow)

// then perform comparison


class tempClass : NSObject {
    

    let dateFormatter:DateFormatter =  {
            let formatter = DateFormatter()
            formatter.dateFormat = "dd MMM yyyy HH:mm:ss Z"
            return formatter
        }()
    
    let timeOnlyFormatter:DateFormatter =  {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter
    }()
    
    let openingTimeString = "27 Aug 2017 05:30:00 +0000"
    let closingTimeString = "27 Aug 2017 10:00:00 +0000"
    
    
    
    var openingTime:Date {
        return dateFormatter.date(from: openingTimeString)!
    }
    
    var closingTime:Date {
        return dateFormatter.date(from: closingTimeString)!
    }
    

    var timeString:String? {
        get {
            var timeString = ""
            var calendar = Calendar.current
            calendar.timeZone = TimeZone.current
            let timeToClose = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: Date(), to: self.closingTime)
            if timeToClose.hour! <= 1 {
                timeString = "Closing in \(timeToClose.minute!) minutes"
            } else {
                timeString = "Open now until \(timeOnlyFormatter.string(from: closingTime))"
            }
            return timeString
        }
        
        
    }
    
}




let newString = tempClass().timeString

//var timer = Timer.scheduledTimer(timeInterval: 1, target: testClassInstance, selector: #selector(tempClass.updateDate), userInfo: nil, repeats: true)
//
//timer.fire()


