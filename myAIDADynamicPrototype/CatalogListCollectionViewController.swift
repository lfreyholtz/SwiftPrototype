//
//  CatalogListCollectionViewController.swift
//  myAIDADynamicPrototype
//
//  Created by Lew Freyholtz on 02.08.17.
//  Copyright © 2017 Lew Freyholtz. All rights reserved.
//

import UIKit
import RealmSwift


class CatalogListCollectionViewController: UICollectionViewController {
    
//    var selectedCellRect:CGRect?
    var segueForDetail = ""
    var navController : UINavigationController?
    var selectedItem: UICollectionViewCell?
    var selectedIndexPath:IndexPath?
    var listData:Category? {
        didSet {
            // init category values instance with type
            
            
        }
    }
    



    struct storyboardValues {
        static let venueCellID = "venueCell"
        static let venueCellNibName = "VenueCell"
        static let defaultCellID = "defaultCell"
        static let venueDetailSegue = "venueDetailSegue"

        
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView!.decelerationRate = UIScrollViewDecelerationRateFast

        
//        self.navigationController?.delegate = self
        
        // Register cell classes
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: storyboardValues.defaultCellID)
        self.collectionView!.register(UINib(nibName: storyboardValues.venueCellNibName, bundle: nil), forCellWithReuseIdentifier: storyboardValues.venueCellID)
        
        
    }
    
    func changeLayout() {
        
    }

}

// MARK: UICollectionViewDataSource
extension CatalogListCollectionViewController {
    

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var count:Int = 1
        

        if let listData = listData {
            let dataType = listData.memberType
            
            switch dataType {
            case "venue":
                count = listData.venueMembers.count
            //case "event":
            default:
                count = 0
            }
        }
            return count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        

        
        if let listData = listData {
            
            let dataType = listData.memberType
            
            
            switch dataType {
                
            case "venue":
                let venueForRow = listData.venueMembers[indexPath.item]
                let venueCell = collectionView.dequeueReusableCell(withReuseIdentifier: storyboardValues.venueCellID, for: indexPath) as! VenueCell
                venueCell.venue = venueForRow
                
                self.segueForDetail = storyboardValues.venueDetailSegue
                
                return venueCell
                
                // case "event":
                
            default:
                print("could not return a data type")
                let defaultCell = collectionView.dequeueReusableCell(withReuseIdentifier: storyboardValues.defaultCellID, for: indexPath) as! DefaultCollectionViewCell
                
                return defaultCell
                
            }
        }
        return UICollectionViewCell()

    }
    
    
}


// MARK: UICollectionViewDelegate
extension CatalogListCollectionViewController {
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        // scroll to selected item
        let layout = collectionViewLayout as! PhotoListLayout
        let offset = layout.dragOffset * CGFloat(indexPath.item)
//        let cell = collectionView.cellForItem(at: indexPath)
        
        selectedIndexPath = indexPath
        selectedItem  = collectionView.cellForItem(at: indexPath)
        
        if collectionView.contentOffset.y < offset {
            collectionView.setContentOffset(CGPoint(x: 0, y: offset), animated: true)
        } else {
            fireSegueWithSelectedCell()
        }


    }
    
    override func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        
        perform(#selector(fireSegueWithSelectedCell), with: nil, afterDelay: 0.3)
    }
    
    func fireSegueWithSelectedCell(){
        if let selectedIndexPath = selectedIndexPath {
            
            if let listData = listData {
                
                let dataType = listData.memberType
                
                switch dataType {
                    
                case "venue":
                    let venue = listData.venueMembers[selectedIndexPath.item]
                    performSegue(withIdentifier: segueForDetail, sender: venue)
                    
                default:
                    break
                }
            }
        }
    
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == storyboardValues.venueDetailSegue {
            let detailController = segue.destination as! VenueDetailViewController
            let selectedVenue = sender as! Venue
            detailController.venue = selectedVenue
            
 
            
        }
    }
    
   
    
}

extension CatalogListCollectionViewController : ZoomingPhotoController {

    
    
    func heroImage(for transition:ZoomingPhotoTransition) -> UIImageView? {
        
        if let selectedIndexPath = selectedIndexPath {
            let cell = collectionView?.cellForItem(at: selectedIndexPath) as! VenueCell
            return cell.venueImage
            
        } else {
            return nil
        }
    }
    
    
    func gradient(for transition: ZoomingPhotoTransition) -> GradientView? {
        if let selectedIndexPath = selectedIndexPath {
            let cell = collectionView?.cellForItem(at: selectedIndexPath) as! VenueCell
            return cell.gradientView
        } else {
            return nil
        }
        
    }
    
    func infoPanel(for transition: ZoomingPhotoTransition) -> UIView? {
        if let selectedIndexPath = selectedIndexPath {
            let cell = collectionView?.cellForItem(at: selectedIndexPath) as! VenueCell
            return cell.venueInfo
        } else {
            return nil
        }
    }
    
}


