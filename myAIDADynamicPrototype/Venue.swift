//
//  Venue.swift
//  myAIDADynamicPrototype
//
//  Created by Lew Freyholtz on 27.06.17.
//  Copyright © 2017 Lew Freyholtz. All rights reserved.
//

import Foundation
import RealmSwift
import AFDateHelper


class Venue : Object {
    

//    dynamic var id = NSUUID().uuidString
    
    dynamic var name:String?
    dynamic var type:CatalogType?
    dynamic var tagline:String?
    dynamic var id = NSUUID().uuidString
    dynamic var location: Location? //wayfinding object
    let images = List<CatalogImage>() //key image should be at 0

    
    dynamic var articleText:String? //description
    
    let isBookable = RealmOptional<Bool>()
    let isPromoted = RealmOptional<Bool>()
    

    let minimumAge = RealmOptional<Int>()
    
    // menu, pricing and inclusion
    dynamic var menu:VenueMenu?
    dynamic var included:String?
    dynamic var notIncluded:String?
    let coverCharge = RealmOptional<Int>()
    
    
    
    //cross referencing
    let categories = List<Category>()
    let tags = List<Tag>()
    
    //logistics
    let openingHours = List<OpeningTime>()
    
    var hoursToday: List<OpeningTime> {
        let hoursList = List<OpeningTime>()


                
        for date in self.openingHours {
            if date.opening?.component(.day) == Date().component(.day) {
                hoursList.append(date)
            }
        }
 
        return hoursList
    }
    
        
  
    var nextOpeningTime:OpeningTime? {
        
        
      if self.isOpen && self.hoursToday.count > 0 {
            
            // look through today's opening times
            for entry in self.hoursToday {
                // return the current one
                if let openingTime = entry.opening, let closingTime = entry.closing {
                    if Date().isBetween(beginDate: openingTime, endDate: closingTime, inclusive: true) {
                        return entry
                    }
                    
                } else {
                    // current item in hours today is nil
                    // print("opening time couldn't be unpacked")
                    return nil
                }
            }
            
        } else {
            // venue is closed, find next opening time
            for entry in self.openingHours {
                if entry.opening?.compare(Date()) == .orderedDescending {
                    return entry
                }
            }
        }
        
        //        print("could not find an opening time - off cruise")
        return nil
    }
    
    
    
    dynamic var popularTimes:String?        //stubbing for image of popular times, rather than the actual data
    
    dynamic var isOpen:Bool {
//        let currentDate:Date = Utils().simDateTime
//        guard let currentDate:Date = Utils().simDateTime else { return false }
        for hours in self.openingHours {
            
            if Date().isBetween(beginDate: hours.opening!, endDate: hours.closing!, inclusive: true) {
                return true
            }
        }
        return false
    }
    
    
    //TODO:reservations, languages
//    let languagesSpoken = List<Language>()
//    let userReservations = List<Reservation>()
    
    //ratings
    let ratingComments = List<RatingComment>()
    let numRatings = RealmOptional<Int>()
    
    let staff = List<Crew>()
    
    //events
    let events = List<Event>()
    
    //favorite / booking
    dynamic var isFavorite = false
    let bookings = List<Booking>()

    
    
    //MARK: meta
    override class func primaryKey() -> String? {
        return "id"
    }
    

    
}


