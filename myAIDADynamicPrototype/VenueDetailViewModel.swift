//
//  VenueDetailViewModel.swift
//  myAIDADynamicPrototype
//
//  Created by LewFreyholtz on 9/29/17.
//  Copyright © 2017 Lew Freyholtz. All rights reserved.
//

import Foundation
import RealmSwift


enum VenueDetailItemType {
    case headerInfo             // image, type, ratings, open now
//    case bookable               // not sure...maybe better in header...
//    case openingHours           // list, hours per day for each day on trip
    case location               // image, text description
//    case included               // text definitions, multiple cells (e.g. Inklusiv...Aufpreis...)
//    case capacity               // popular times chart, capacity
    case article                // article description
//    case menu                   // button
//    case ratings                // overall rating
//    case reviews                // list of reviews
//    case events                 // list of events
//    case promotions             // list of promotions
//    case reservations           // list of existing reservations
//    case similarVenues          // collection
//    case tags                   // tags for venue
}


protocol VenueDetailModelItem {
    var type:VenueDetailItemType { get }
    var sectionTitle: String { get }        // some sections have titles, others do not
    var collapsible:Bool { get }            // some sections are collapsible
    var sectionIconName:String { get }
    var rowCount:Int { get }
}

extension VenueDetailViewModel {
    var rowCount: Int {
    
        return 1
    }
}

// MARK: VIEW MODEL
class VenueDetailViewModel : NSObject {
    
    var items = [VenueDetailModelItem]() // array containing items and their data
    var venue:Venue?
    
    init(venue:Venue?) {
        super.init()
        
        
        guard let venue = venue else { return }
        let venueImages = venue.images
        let defaultImage = venueImages.first
        let keyImageName = defaultImage?.imageName
        
        
        // header
        if let name = venue.name, let tagline = venue.tagline, let type = venue.type?.typeName, let typeDescription = venue.type?.description, let keyImageName = keyImageName {

            let headerItem = VenueDetailModelHeaderInfoItem(
                name: name,
                typeDescription: typeDescription,
                tagline: tagline,
                keyImageName: keyImageName,
                venueType: type)
            
            items.append(headerItem)
        
        }
        // location
        
        if let location = venue.location {
            let locationItem = VenueDetailModelLocationItem(location: location)
            items.append(locationItem)
        }
        
        // article
        if let title = venue.tagline, let articleText = venue.articleText {
            let articleItem = VenueDetailModelArticleItem(title: title, body: articleText)
            items.append(articleItem)
        }
        
        
        
    }
    
}

// MARK: SECTION CLASSES
// Venue Header
class VenueDetailModelHeaderInfoItem : VenueDetailModelItem {
    

    var type: VenueDetailItemType {
        return .headerInfo
        
    }
    
    var rowCount: Int {
        return 0 // has no rows
    }
    // has no section title
    var sectionTitle: String {
        return ""
    }
    
    // has no collapsible section
    var collapsible: Bool {
        return false
    }
    
    // has no section icon
    var sectionIconName: String {
        return ""
    }
    
    
    var name: String
    var tagline:String
    var venueType:String
    var typeDescription: String
    var keyImageName: String
    
    
    // for later
//    var rating: CGFloat
//    var totalRatings: Int
//    var isOpen:Bool
//    var occupancy:CGFloat
//    var isFavorite:Bool
//    
    init(name:String, typeDescription:String, tagline:String, keyImageName:String, venueType:String) {
        self.name = name
        self.typeDescription = typeDescription
        self.tagline = tagline
        self.keyImageName = keyImageName
        self.venueType = venueType
    }
}

//class VenueDetailModelOpeningTimesItem : VenueDetailModelItem {
//    
//    var type: VenueDetailItemType {
//        return .openingHours
//    }
//    
//    var sectionTitle: String {
//        return "OFFNUGSZEITEN"
//    }
//    
//    var collapsible: Bool {
//        return true
//    }
//    var sectionIconName: String {
//        return "icn_clock"
//    }
//    var openingTimes: List<OpeningTime>
//    var rowCount: Int {
//        return openingTimes.count
//    }
//    
//    init(openingTimes:List<OpeningTime>) {
//        self.openingTimes = openingTimes
//    }
//    
//}
//
class VenueDetailModelLocationItem: VenueDetailModelItem {
    var type: VenueDetailItemType {
        return .location
    }
    
    var rowCount: Int {
        return 1
    }
    
    
    var location: Location!
    var sectionTitle: String {
        return String("ORT \(location.locationDeck!)").uppercased()
    }
    
    var sectionIconName: String {
        return "icn_location"
    }
    
    var collapsible: Bool {
        return true
    }
    
    var locName:String {
        return location.locationTitle!
    }
    var locationImageName:String {
        return location.deckPlan!
    }
    
    var locationTitle:String {
        return String("\(self.locName), \(location.locationDeck!)")
    }
    
    
    init(location:Location) {
        self.location = location
    }
    
    
}

class VenueDetailModelArticleItem : VenueDetailModelItem {
    
    var type: VenueDetailItemType {
        return .article
    }
    
    var sectionIconName: String {
        return ""
    }
    
    var rowCount:Int {
        return 1
    }
    
    
    var sectionTitle: String {
        return ""
    }
    
    var collapsible: Bool {
        return false
    }
    
    
    var title:String
    var body:String
//    var author:Crew?
    
    init(title:String, body:String) {
        self.body = body
        self.title = title
    }
    
}


extension VenueDetailViewModel : UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items[section].rowCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = items[indexPath.row]
        switch item.type {
            case .headerInfo:
                break
        
            case .article:
                if let cell = tableView.dequeueReusableCell(withIdentifier: DescriptionCellTableViewCell.identifier, for:indexPath) as? DescriptionCellTableViewCell {
                    cell.article = item
                    return cell
                }
        case .location:
            break

        }
        
        return UITableViewCell()
    }
    
}
