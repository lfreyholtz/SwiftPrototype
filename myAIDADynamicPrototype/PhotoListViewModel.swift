//
//  PhotoListViewModel.swift
//  myAIDADynamicPrototype
//
//  Created by LewFreyholtz on 10/12/17.
//  Copyright © 2017 Lew Freyholtz. All rights reserved.
//

import Foundation
import RealmSwift


enum PhotoListModelItemType {
    
    case venue
    case event
    case excursion
}



protocol PhotoListModelItem {
    var type:PhotoListModelItemType { get }
    
}




class PhotoListViewModel : NSObject {


    
    var items = [PhotoListModelItem]()
    var refreshCollection:(() -> Void)?
    var performSegue:((_ selectedItem:Object) -> Void)?
    
    init(category:Category?) {
        super.init()
        
        guard let category = category else { return }
        
        if category.memberType == "venue" {

            for venue in category.venueMembers {
                let coverViewModel = VenueCoverViewModel(venue: venue)
                let venueItem = PhotoListModelVenueItem(venue: venue, coverViewModel:coverViewModel)
                items.append(venueItem)
            }
            
            self.sortVenueList()
            
        }
        
        
    }
    
    func sortVenueList() {
        if items.count < 1 {
            return
        }
        
//        print("Sorting list")
        items.sort { item1, item2 in
            let venue1 = item1 as! PhotoListModelVenueItem
            let venue2 = item2 as! PhotoListModelVenueItem
            guard let v1NextOpening = venue1.nextOpeningTime else { return false }
            guard let v2NextOpening = venue2.nextOpeningTime else { return false }
            
            if venue1.venueIsOpen == venue2.venueIsOpen {
                if venue1.venueIsOpen == true {
                    guard let venue1NextClosing = v1NextOpening.closing else { return false }
                    guard let venue2NextClosing = v2NextOpening.closing else { return false }
                    return venue1NextClosing < venue2NextClosing
                    
                } else if venue1.venueIsOpen == false {
                    guard let venue1NextOpening = v1NextOpening.opening else { return false }
                    guard let venue2NextOpening = v2NextOpening.opening else { return false }
                    return venue1NextOpening < venue2NextOpening
                }
            }
            return venue1.venueIsOpen && !venue2.venueIsOpen
        }
        
        
        // for testing
        for item in self.items {
            guard let newItem = item as? PhotoListModelVenueItem else { return }
            let openString:String = newItem.venueIsOpen ? "open" : "closed"
//            print("\(newItem.venue!.name!) is \(openString)")
        
        }
        refreshCollection?()
        
    }

    // sort other lists
}


// types
// Venue
protocol PhotoListModelVenueItemDelegate {
    func venueOpenStatusDidChange()
}
class PhotoListModelVenueItem : PhotoListModelItem {
    var timer = Timer()
    
    var delegate:PhotoListModelVenueItemDelegate?
    var type:PhotoListModelItemType {
        return .venue
    }
    
    
    var venue:Venue?
    
    var coverViewModel:VenueCoverViewModel?

    
    private var venueIsOpenStore:Bool  = false {
        didSet {
            if venueIsOpenStore != oldValue {
                delegate?.venueOpenStatusDidChange()
            }
            
        }
    }
    var venueIsOpen:Bool {
        
        get {
            guard self.venue != nil else { return false }
            return self.venue!.isOpen()
        }
        set {
            if newValue == true {
                timer.fire()
            } else if newValue == false {
                timer.invalidate()
            }
            self.venueIsOpenStore = newValue
        }
    }
   
    var nextOpeningTime:OpeningTime? {
        guard let venue = venue else { return OpeningTime() }
        return venue.nextOpeningTime()
    }
   
    
    
    init(venue:Venue?, coverViewModel:VenueCoverViewModel) {
        guard let venue = venue else { return }
        self.venue = venue
        self.coverViewModel = coverViewModel
//        self.venueIsOpen = venue.isOpen()
        self.checkOpenStatus()
        self.runTimer()
    }
    

    @objc func checkOpenStatus() {
        guard let venue = self.venue else { return }
        self.venueIsOpenStore = venue.isOpen()
    }
    
    func runTimer() {
        self.timer = Timer.scheduledTimer(timeInterval: 60, target: self, selector: (#selector(checkOpenStatus)), userInfo: nil, repeats: true)
    }
    
    deinit {
        self.timer.invalidate()
    }
}


// Event
class PhotoListModelEventItem : PhotoListModelItem {
    
    
    var type:PhotoListModelItemType {
        return .event
    }
    
    
}

class PhotoListModelExcursionItem : PhotoListModelItem {
    
    
    var type:PhotoListModelItemType {
        return .excursion
    }
    
    
}
// MARK: UICollectionViewDataSource
extension PhotoListViewModel : UICollectionViewDataSource {
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = items[indexPath.item]
        switch item.type {
            
        case .venue:
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: VenueCell.identifier, for: indexPath) as? VenueCell {
            cell.cellViewModel = item
            return cell
            }
        default:
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DefaultCollectionViewCell.identifier, for: indexPath) as? DefaultCollectionViewCell {
            return cell
            }
        }
        return UICollectionViewCell()
    }

    
}

// MARK: UICollectionViewDelegate
extension PhotoListViewModel : UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let selectedItem = collectionView.cellForItem(at: indexPath) as! VenueCell
        let itemViewModel = selectedItem.cellViewModel as! PhotoListModelVenueItem
        let selectedVenue = itemViewModel.venue
        performSegue!(selectedVenue!)
//        let offset = layout.dragOffset * CGFloat(indexPath.item)
        
    }
    

    
    
}
