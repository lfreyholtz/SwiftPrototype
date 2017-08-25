//
//  Venue.swift
//  myAIDADynamicPrototype
//
//  Created by Lew Freyholtz on 27.06.17.
//  Copyright © 2017 Lew Freyholtz. All rights reserved.
//

import Foundation
import RealmSwift

class Venue : Object {
    
    dynamic var venueID = NSUUID().uuidString
    dynamic var name:String?
    dynamic var type:CatalogType?
    dynamic var tagline:String?
    
    
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
        return "venueID"
    }
    
}
