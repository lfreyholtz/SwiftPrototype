//
//  Utils.swift
//  myAIDADynamicPrototype
//
//  Created by Lew Freyholtz on 23.08.17.
//  Copyright © 2017 Lew Freyholtz. All rights reserved.
//

import UIKit
import Foundation
import RealmSwift
import AFDateHelper



class Utils: NSObject {


    // simulation date
    var simTimeZone:TimeZone = TimeZone.current
    var simDateTime:Date? {
//        let testDateString = "27 Aug 2017 06:31:00 +0000"
//        
////        let timeZone = TimeZone(abbreviation: "UTC") 
////        let calendar = Calendar.current
//        
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "dd MMM yyyy HH:mm:ss Z"
//        print("testDate and Time: \(dateFormatter.date(from: testDateString)!)")
//        return dateFormatter.date(from: testDateString)
        return Date()
    }
    
    
    //dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
    
    
    
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


    
    func generateOpeningHours(){
        let mainRealm = try! Realm(configuration: RealmConfig.main.configuration)
//        let restaurantsOnly = mainRealm.objects(Venue.self).filter("type.typeName = 'buffet' OR type.typeName = 'service' OR type.typeName = 'alacarte'")
        let snackbars = mainRealm.objects(Venue.self).filter("type.typeName = 'snackbar'")
        let bars = mainRealm.objects(Venue.self).filter("type.typeName = 'bar'")
        let times = List<OpeningTime>()
        let startDate = Date(fromString: "27 Aug 2017 0:00:00 +0000", format: .altRSS)
        let cruiseDays = 7
//        let amOpenHours = [5, 6, 7, 8]
//        let lunchOpenHours = [10, 11, 12, 13]
//        let dinnerOpenHours = [17,18,19,20]
//        let halfHourOptions = [0, 30]
//        var descriptor:String
        
        for item in bars {
            //day
            for day in 0...cruiseDays {
                // breakfast
                let curCruiseDay = startDate?.adjust(.day, offset: day)
//                print("******* venue:\(item.name!) *********")
//                print("\(curCruiseDay!.toString(style: .full))")
                
                let barOpen = curCruiseDay?.adjust(.hour, offset: 21)
                let barClose = barOpen?.adjust(.hour, offset: 6)
                let barOpeningTime = OpeningTime()
                    barOpeningTime.opening = barOpen!
                    barOpeningTime.closing = barClose!
                    barOpeningTime.timeDescriptor = "bar / nightclub"
                
                times.append(barOpeningTime)
//                try! mainRealm.write {
//                    item.openingHours.append(barOpeningTime)
//                }
                
//                let snackBarOpen = curCruiseDay?.adjust(.hour, offset:14)
//                let finalSnackBarOpen = snackBarOpen?.adjust(.minute, offset:30)
//                let snackBarClose = finalSnackBarOpen?.adjust(.hour, offset:9)
//                let snackbarOpeningTime = OpeningTime()
//                    snackbarOpeningTime.opening = finalSnackBarOpen!
//                    snackbarOpeningTime.closing = snackBarClose!
//                    snackbarOpeningTime.timeDescriptor = "snackbar"
//                
//                times.append(snackbarOpeningTime)
//                try! mainRealm.write {
//                    item.openingHours.append(snackbarOpeningTime)
//                }
//                let randomBreakfastOpen = amOpenHours[Int(arc4random_uniform(UInt32(amOpenHours.count)))]
//                let randomHalfHour = halfHourOptions[Int(arc4random_uniform(UInt32(halfHourOptions.count)))]
//                
//
//                let breakfastHour = curCruiseDay?.adjust(.hour, offset:randomBreakfastOpen)
//                let breakfastFinal = breakfastHour?.adjust(.minute, offset: randomHalfHour)
//                let breakfastClose = breakfastFinal?.adjust(.hour, offset: 3)
//                
//
//                let breakfastOpeningTime = OpeningTime()
//                    breakfastOpeningTime.timeDescriptor = "Breakfast"
//                    breakfastOpeningTime.opening = breakfastFinal!
//                    breakfastOpeningTime.closing = breakfastClose!
//                
//                
//                times.append(breakfastOpeningTime)

                
////                item.openingHours.append(breakfastOpeningTime)
////                print("BREAKFAST")
////                print("-- Breakfast opens at:\(breakfastFinal!)")
////                print("-- Breakfast closes at:\(breakfastClose!)")
//                
//                // lunch
////                print("LUNCH")
//
//                let randomLunchOpen = lunchOpenHours[Int(arc4random_uniform(UInt32(lunchOpenHours.count)))]
//                let lunchHour = curCruiseDay?.adjust(.hour, offset:randomLunchOpen)
//                let lunchFinal = lunchHour?.adjust(.minute, offset: randomHalfHour)
//                let lunchClose = lunchFinal?.adjust(.hour, offset: 3)
//                
//                
//                let lunchOpeningTime = OpeningTime()
//                    lunchOpeningTime.opening = lunchFinal!
//                    lunchOpeningTime.closing = lunchClose!
//                    lunchOpeningTime.timeDescriptor = "Lunch"
//                
//                times.append(lunchOpeningTime)
////                item.openingHours.append(lunchOpeningTime)
////                print("-- Lunch opens at:\(lunchFinal!)")
////                print("-- Lunch closes at:\(lunchClose!)")
//
//                
//                // dinner
////                print("DINNER")
////                descriptor = "Dinner"
//                let randomDinnerOpen = dinnerOpenHours[Int(arc4random_uniform(UInt32(dinnerOpenHours.count)))]
//                let dinnerHour = curCruiseDay?.adjust(.hour, offset:randomDinnerOpen)
//                let dinnerFinal = dinnerHour?.adjust(.minute, offset: randomHalfHour)
//                let dinnerClose = dinnerFinal?.adjust(.hour, offset: 3)
//                
//                
//
//                let dinnerOpeningTime = OpeningTime()
//                    dinnerOpeningTime.closing = dinnerClose!
//                    dinnerOpeningTime.opening = dinnerFinal!
//                    dinnerOpeningTime.timeDescriptor = "Dinner"
//                
//                times.append(dinnerOpeningTime)
//                try! mainRealm.write {
//                    item.openingHours.append(breakfastOpeningTime)
//                    item.openingHours.append(lunchOpeningTime)
//                    item.openingHours.append(dinnerOpeningTime)
//                 
//                }


//                print("-- Lunch opens at:\(dinnerFinal!)")
//                print("-- Lunch closes at:\(dinnerClose!)")
//
//                print("\r\n \r\n")
                
                
            }


            print(times)
            

            
        }

    }
}
