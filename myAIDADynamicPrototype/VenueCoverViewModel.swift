//
//  CatalogCoverViewModel.swift
//  myAIDADynamicPrototype
//
//  Created by LewFreyholtz on 10/4/17.
//  Copyright © 2017 Lew Freyholtz. All rights reserved.
//

import Foundation
import RealmSwift



class VenueCoverViewModel : NSObject {
    
    var venue:Venue?
    var venueName: String?
    var tagline:String?
    var venueType:String?
    var typeDescription: String?
    var keyImageName: String?
    // for later
    //    var rating: CGFloat
    //    var totalRatings: Int
    var isOpen:Bool?
    var openMessage:String?
    
    
    // calendar settings
    
    let calendar = Calendar.current
    
    // formatters for dates
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
    
    let relativeDateFormatter:DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "de-DE") // to keep things in german for now, even on "english" test device
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        formatter.doesRelativeDateFormatting = true
        return formatter
    
    }()
    
    
    let componentFormatter:DateComponentsFormatter = {
        let formatter = DateComponentsFormatter()
        formatter.calendar = Calendar.current
        formatter.maximumUnitCount = 2
        formatter.zeroFormattingBehavior = .default
        formatter.allowsFractionalUnits = false
        formatter.allowedUnits = [.weekday, .year, .month, .weekOfMonth, .day, .hour, .minute, .second]
        return formatter
    }()
    
    // string displayed for opening time
    var openingMessage:String? {
        var returnString:String?
        
        guard let venue = self.venue else { print("no venue"); return "" }
        guard let nextOpeningTime = venue.nextOpeningTime else { print("not open, on cruise"); return "" }
        let timeToClose = calendar.dateComponents([.weekday, .year, .month, .day, .hour, .minute], from: Date(), to: nextOpeningTime.closing!)
        
        if venue.isOpen {
            if timeToClose.hour! <= 1 {
                if timeToClose.minute! <= 1 {
                    returnString = "Geöffnet: schließt in \(timeToClose.minute!) Minute"
                } else {
                    returnString = "Geöffnet: schließt in \(timeToClose.minute!) Minuten"
                }
                
            } else {
                returnString = "Jetzt geöffnet bis \(timeOnlyFormatter.string(from: nextOpeningTime.closing!)) Uhr"
            }
            
        } else {
            
            // TODO: Improve this by creating a localized set of relative date values
            let timeToClose = calendar.dateComponents([.weekday, .year, .month, .day, .hour, .minute], from: Date(), to: nextOpeningTime.opening!)
            print(timeToClose)
            returnString = "Geschlossen: öffnet \(relativeDateFormatter.string(from: nextOpeningTime.opening!)) Uhr"
            
// TODO: case for opening exactly one week later
// TODO: case for opening on a day this week
            
            
        }
        print(returnString!)
        return returnString ?? ""
    }
    // if open, returns current opening time.  If closed, returns next.  If none for voyage or if venue fails, will return nil.

    
    init(venue:Venue) {
        super.init()
        self.venue = venue
//        guard let venue = venue else { return }
        self.venueName = venue.name
        self.tagline = venue.tagline
        self.venueType = venue.type?.typeName
        self.typeDescription = venue.type?.typeDescription
        self.keyImageName = venue.images.first?.imageName
        self.isOpen = venue.isOpen
        
//        setUpOpenStringFor(venue: venue)
        
    }
    


    
}
