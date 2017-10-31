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
    

    var rating:Double {
        guard let venue = venue else { return 0 }
        if venue.ratings.count > 0 {
            return venue.ratings.average(ofProperty: "ratingValue")!
        } else {
            return 0
        }
    }
    
    var totalRatings: Int {
        guard let venue = venue else { return 0 }
        return venue.ratings.count
    }
//    var isOpen:Bool
    var openMessage:String?
    
//    var isOpen:Bool {
//        didSet(newValue) {
//            if self.isOpen != newValue {
//                print("isOpen in coverViewModel was changed")
//            }
//        }
//    }
//    
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
    
    let dayOfWeekFormatter:DateFormatter = {
    
        let formatter = DateFormatter()
        formatter.calendar = Calendar.current
        formatter.locale = Locale(identifier: "de-DE") // to keep things in german for now, even on "english" test device
        formatter.dateFormat = "EEEE"
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
    var openingMessage:String {
    
        var openingString:String = "Geschlossen"
        guard let venue = self.venue else { return "" }
       
        if let nextOpeningTime = venue.nextOpeningTime() {
            
            switch venue.isOpen() {
                
                case true:
                     let timeToClose = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: Date(), to:nextOpeningTime.closing!)
                     let minutesPlural = timeToClose.minute! > 1 ? "Minuten" : "Minute"
                
                     if timeToClose.hour! < 1 {
                        if timeToClose.minute! <= 1 {
                            openingString = "Jezt geöffnet, schliesst gleich"
                        } else {
                            openingString = "Jetzt geöffnet, schliesst in \(timeToClose.minute!) \(minutesPlural)"
                        }
                     } else {
                        openingString = "Jetzt geöffnet bis \(timeOnlyFormatter.string(from: nextOpeningTime.closing!))"
                }
                
                
            
                default:

                    let timeToOpen = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: Date(), to: nextOpeningTime.opening!)
                    if timeToOpen.day! > 1 && timeToOpen.day! < 6 {
                        openingString = "Geschlossen, öffnet \(dayOfWeekFormatter.string(from: nextOpeningTime.opening!)) um \(timeOnlyFormatter.string(from: nextOpeningTime.opening!))"
                    } else {
                        openingString = "Geschlossen, öffnet \(relativeDateFormatter.string(from:nextOpeningTime.opening!))"
                    }

                }

                
                
            }

//        print(openingString)
        return openingString
    }

    
    init(venue:Venue) {
        super.init()
//        print("venue view model init run")
        self.venue = venue
//        guard let venue = venue else { return }
        self.venueName = venue.name
        self.tagline = venue.tagline
        self.venueType = venue.type?.typeName
        self.typeDescription = venue.type?.typeDescription
        self.keyImageName = venue.images.first?.imageName
        
        
//        self.isOpen = venue.isOpen()
        
//        setUpOpenStringFor(venue: venue)
        
    }
    


    
}
