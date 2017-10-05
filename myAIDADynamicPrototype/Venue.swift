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
    
//    var hoursToday: List<OpeningTime> {
//        let hoursList = List<OpeningTime>()
//        let today = Utils().simDateTime
//        for hours in self.openingHours {
//        
//            if let openString = hours.openTimeDate, let closeString = hours.closeTimeDate {
//                let openDate = Date(fromString: openString, format: .custom("yyyy-MM-dd HH:mm:ss"))
//                let closeDate = Date(fromString: closeString, format: .custom("yyyy-MM-dd HH:mm:ss"))
//                if let openDate = openDate, let closeDate = closeDate {
//                    if today.compare(.isSameDay(as: openDate)) && today.compare(.isSameDay(as: closeDate)) {
//                        hoursList.append(hours)
//                    }
//                }
//
//            }
//        }
//        
//        return hoursList
//    }
    
        
  
    
    
    dynamic var popularTimes:String?        //stubbing for image of popular times, rather than the actual data
    
    dynamic var isOpen:Bool {
//        let currentDate:Date = Utils().simDateTime
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
//        for hours in self.openingHours {
//            if let openString = hours.openTimeDate, let closeString = hours.closeTimeDate {
//                
//                guard let openDate = Date(fromString: openString, format: .custom("yyyy-MM-dd HH:mm:ss")) else { return false }
//                guard let closeDate = Date(fromString: closeString, format: .custom("yyyy-MM-dd HH:mm:ss")) else { return false }
//                if currentDate.isBetween(beginDate: openDate, endDate: closeDate, inclusive: true) {
//                    return true
//                }
//            }
//        }
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
