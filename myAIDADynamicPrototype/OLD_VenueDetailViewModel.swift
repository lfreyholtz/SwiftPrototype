////
////  VenueDetailViewModel.swift
////  myAIDADynamicPrototype
////
////  Created by LewFreyholtz on 9/29/17.
////  Copyright © 2017 Lew Freyholtz. All rights reserved.
////
//
//import Foundation
//import RealmSwift
//
//
////enum VenueDetailItemType {
//////    case bookable               // not sure...maybe better in header...
////    case openingHours           // list, hours per day for each day on trip
////    case location               // image, text description
////    case included               // text definitions, multiple cells (e.g. Inklusiv...Aufpreis...)
//////    case capacity               // popular times chart, capacity
////    case article                // article description
//////    case menu                   // button
//////    case ratings                // overall rating
//////    case reviews                // list of reviews
//////    case events                 // list of events
//////    case promotions             // list of promotions
//////    case reservations           // list of existing reservations
//////    case similarVenues          // collection
//////    case tags                   // tags for venue
////}
//
//protocol OLD_VenueDetailModelDelegate {
//
//    func scrollViewDidScroll(scrollView:UIScrollView)
//}
//
//protocol VenueDetailModelItem {
//    var type:VenueDetailItemType { get }    // this is where the destinction would need to be made between venue, event, etc, effectively switching the enum
//    var hasHeader:Bool { get }
//
//    var sectionTitle: String { get }        // some sections have titles, others do not
//    var collapsible:Bool { get }            // some sections are collapsible
//    var isCollapsed:Bool { get set }        // to see if it's collapsed
//    var sectionIconName:String { get }
//    var rowCount:Int { get }
//
//}
//
//
//
//extension VenueDetailModelItem {
//
//    var rowCount: Int {
//        return 1
//
//    }
//
//    var hasHeader:Bool {
//        return false
//    }
//
//    var collapsible: Bool {
//        return false
//    }
//
//
//}
//
//
//
//// MARK: VIEW MODEL
//class VenueDetailViewModel : NSObject {
//    var delegate:VenueDetailModelDelegate?
//
//
//    var items = [VenueDetailModelItem]() // array containing items and their data
//    var venue:Venue?
//    var headerInfoModel:VenueCoverViewModel?
//
//    // callback to tableViewSections
//    var reloadSections: ((_ section: Int) -> Void)?
//
//
//    init(venue:Venue?) {
//        super.init()
//
//        print("venue detail view model init run")
//        guard let venue = venue else { return }
//
//        // header info view
//        headerInfoModel = VenueCoverViewModel(venue: venue)
////        if let name = venue.name, let tagline = venue.tagline, let type = venue.type?.typeName, let typeDesc = venue.type?.typeDescription, let keyImageName = venue.images.first?.imageName {
////
////            headerInfoModel = VenueCoverViewModel(venue: venue)
////        }
//
//        // hours
//        if venue.openingHours.count > 0 {
//            let timesItem = VenueDetailModelOpeningTimesItem(openingHours: venue.openingHours)
//            items.append(timesItem)
//        }
//
//        // location
//
//        if let location = venue.location {
//            let locationItem = VenueDetailModelLocationItem(location: location)
//            items.append(locationItem)
//        }
//
//        // what's included
//        if let included = venue.included, let excluded = venue.notIncluded {
//            let includedItem = VenueDetailIncludedItem(includedItems: included, excludedItems: excluded)
//            items.append(includedItem)
//        }
//
//        // article
//        if let title = venue.tagline, let articleText = venue.articleText {
//            let articleItem = VenueDetailModelArticleItem(title: title, body: articleText)
//            items.append(articleItem)
//        }
//
//
//
//
//    }
//
//}
//
//
//
//// MARK: SECTION CLASSES
//
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
//    var hasHeader: Bool {
//        return true
//    }
//
//    var sectionIconName: String {
//        return "icn_time"
//    }
//
//    var collapsible: Bool {
//        return true
//    }
//
//    var isCollapsed = true
//
////    var todaysHours:List<OpeningTime>
//    var venueOpeningTimes: List<OpeningTime>
//
//    var todaysHours:List<OpeningTime> {
//        let todaysList = List<OpeningTime>()
//        if venueOpeningTimes.count > 0 {
////            var tomorrow = Date().adjust(.day, offset: 1)
////            var datesTodayPredicate = NSPredicate(format: "opening BETWEEN %@", Date(), tomorrow)
////            return self.venueOpeningTimes.filter(datesTodayPredicate)
////        }
//
//            for date in self.venueOpeningTimes {
//                if Calendar.current.compare(Date(), to: date.opening!, toGranularity: .day) == .orderedSame && Calendar.current.compare(Date(), to: date.closing!, toGranularity: .minute) == .orderedAscending {
//
//                    todaysList.append(date)
//                }
//            }
//
//        }
//        return todaysList
//    }
////    var tomorrowsHours:List<OpeningTime> {
////        let openingTimes = List<OpeningTime>()
////
////        for date in self.venueOpeningTimes {
////            if Calendar.current.compare(Date(), to: date.opening!, toGranularity: .day) == .orderedSame && Calendar.current.compare(Date(), to: date.closing!, toGranularity: .minute) == .orderedAscending {
////
////                openingTimes.append(date)
////            }
////        }
////        return openingTimes
////
////    }
//
//    var rowCount: Int {
//        return 1
//    }
//
//    init(openingHours:List<OpeningTime>) {
//        self.venueOpeningTimes = openingHours
////        self.venueOpeningTimes = openingHours
//    }
//
//}
////
//class VenueDetailModelLocationItem: VenueDetailModelItem {
//
//    var type: VenueDetailItemType {
//        return .location
//    }
//
//
//    var location: Location!
//
//
//    var hasHeader: Bool {
//        return true
//    }
//
//    var sectionTitle: String {
//        return String("ORT: \(location.locationDeck!)").uppercased()
//    }
//
//    var sectionIconName: String {
//        return "icn_location"
//    }
//
//    var collapsible: Bool {
//        return true
//    }
//
//    var isCollapsed = true
//
//
//    var locName:String {
//        return location.locationTitle!
//    }
//    var locationImageName:String {
//        return location.deckPlan!
//    }
//
//    var locationTitle:String {
//        return String("\(self.locName), \(location.locationDeck!)")
//    }
//
//
//    init(location:Location) {
//        self.location = location
//    }
//
//
//}
//
//class VenueDetailModelArticleItem : VenueDetailModelItem {
//
//    var type: VenueDetailItemType {
//        return .article
//    }
//
//    var sectionIconName: String {
//        return ""
//    }
//
//    var rowCount:Int {
//        return 1
//    }
//
//
//    var sectionTitle: String {
//        return ""
//    }
//
//
//    // not collapsible, not collapsed
//    var collapsible: Bool {
//        return false
//    }
//
//    var isCollapsed = false
//
//
//    var title:String
//    var body:String
////    var author:Crew?
//
//    init(title:String, body:String) {
//        self.body = body
//        self.title = title
//    }
//
//}
//
//
//// inlcuded
//
//class VenueDetailIncludedItem : VenueDetailModelItem {
//    var type: VenueDetailItemType {
//        return .included
//    }
//
//    var sectionTitle: String {
//        return String("INKLUSIVELEISTUNGEN:").uppercased()
//    }
//
//    var hasHeader: Bool {
//        return true
//    }
//    var sectionIconName: String {
//        return "icn_pricing"
//    }
//    var collapsible: Bool {
//        return true
//    }
//
//    var isCollapsed = true
//
//    var includedItems:String
//    var excludedItems:String
//
//    init(includedItems:String, excludedItems:String) {
//        self.includedItems = includedItems
//        self.excludedItems = excludedItems
//    }
//}
//
//// MARK: TABLEVIEW DELEGATE / DATASOURCE
//
//extension VenueDetailViewModel : UITableViewDataSource {
//
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return items.count
//    }
//
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return items[section].sectionTitle
//    }
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//
//
//        let item = items[section]
//        guard item.collapsible else {
//            return item.rowCount
//        }
//
//        if item.isCollapsed {
//            return 0
//        }  else {
//            return item.rowCount
//        }
//    }
//
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//        let item = items[indexPath.section]
//        let separatorInset = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)
//
//
//        switch item.type {
//
//            case .article:
////                print("Adding article cell")
//                if let cell = tableView.dequeueReusableCell(withIdentifier: DescriptionCellTableViewCell.identifier, for:indexPath) as? DescriptionCellTableViewCell {
//                    cell.article = item
//
//                    cell.setNeedsDisplay()
//                    cell.layoutIfNeeded()
//
//                    cell.preservesSuperviewLayoutMargins = false
//                    cell.separatorInset = separatorInset
//
//                    return cell
//                }
//
//            case .location:
////                print("Adding location cell")
//                if let cell = tableView.dequeueReusableCell(withIdentifier: LocationTableViewCell.identifier, for:indexPath) as? LocationTableViewCell {
//                    cell.location = item
//                    cell.preservesSuperviewLayoutMargins = false
//                    cell.separatorInset = separatorInset
//                    return cell
//                }
//
//            case .included:
////                print("Adding included cell")
//                if let cell = tableView.dequeueReusableCell(withIdentifier: IncludedTableViewCell.identifier, for:indexPath) as? IncludedTableViewCell {
//                    cell.included = item
//                    cell.preservesSuperviewLayoutMargins = false
//                    cell.separatorInset = separatorInset
//                    return cell
//                }
//
//            case .openingHours:
//                //                print("Adding times cell")
//                if let cell = tableView.dequeueReusableCell(withIdentifier: TimesCell.identifier, for:indexPath) as? TimesCell {
//                    cell.openingHours = item
//                    cell.preservesSuperviewLayoutMargins = false
//                    cell.separatorInset = separatorInset
//                    return cell
//                }
//
//        }
//
//        return UITableViewCell()
//    }
//
//
//}
//
//extension VenueDetailViewModel : UITableViewDelegate {
//
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
////        print("Adding section header to section \(section)")
//
//        let item = items[section]
////        print(item.hasHeader)
//
//        if !item.hasHeader {
//            return nil
//        } else {
//            if let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: ExpandableHeader.identifier) as? ExpandableHeader {
//
//                headerView.item = items[section]
//                headerView.section = section
//                headerView.delegate = self
//                return headerView
//            }
//
//        }
//
//        return nil
//
//    }
//
//    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
//        return UITableViewAutomaticDimension
//    }
//
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        let item = items[section]
////        print("Has header: \(item.hasHeader.hashValue)")
////        if item.hasHeader {
////            return 57
////        } else {
////            return 0
////        }
//        return CGFloat(item.hasHeader.hashValue * 57)
//
//    }
//
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        delegate?.scrollViewDidScroll(scrollView: scrollView)
//    }
//
//
//}
//
//extension VenueDetailViewModel : ExpandableHeaderDelegate {
//
//    func toggleSection(header: ExpandableHeader, section: Int) {
//        var item = items[section]
//        if item.collapsible {
//
//            let collapsed = !item.isCollapsed
//            item.isCollapsed = collapsed
//            header.setCollapsed(collapsed: collapsed)
////            print("reloading sections")
//            reloadSections?(section)
//        }
//    }
//}

