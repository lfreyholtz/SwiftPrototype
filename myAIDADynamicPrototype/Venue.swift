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
    
    
    
    dynamic var popularTimes:String?        //stubbing for image of popular times, rather than the actual data
    

    
    //TODO:reservations, languages
//    let languagesSpoken = List<Language>()
//    let userReservations = List<Reservation>()
    
    //ratings
    let ratings = List<Rating>()
    
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
    

    func hoursToday() -> Results<OpeningTime> {
        
        let todayStart = Calendar.current.startOfDay(for: Date())
        let todayEnd:Date = {
            let components = DateComponents(day:1, second:-1)
            return Calendar.current.date(byAdding:components, to: todayStart)!
        }()
        let filteredList = self.openingHours.filter("opening BETWEEN %@", [todayStart, todayEnd])
        return filteredList.sorted(byKeyPath: "opening", ascending: true)
    }
    
    
    func nextOpeningTime() -> OpeningTime? {
        
        let todaysHours: Results<OpeningTime> = hoursToday()
        let allSortedHours = self.openingHours.sorted(byKeyPath: "opening", ascending: true)
        
        if self.isOpen() {

            return todaysHours.filter("(opening <= %@) AND (closing >= %@)", Date(), Date()).first
        }
        return allSortedHours.filter("opening >= %@", Date()).first
    }
    
    
    
    func isOpen() -> Bool {
        
        let todaysHours: Results<OpeningTime> = hoursToday()
        // assuming if no opening hours venue is closed

        return todaysHours.filter("(opening <= %@) AND (closing >= %@)", Date(), Date()).count >= 1

        
    }
}


