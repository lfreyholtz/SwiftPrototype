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
//            print(listData?.venueMembers)
            
        }
    }
    


    // for hiding statusbar
    var statusBarHidden:Bool = false {
        didSet {
            self.setNeedsStatusBarAppearanceUpdate()
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
        
        // custom back icon
        let icon = UIImage(named:"icn_back_white")
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: icon,
            style: UIBarButtonItemStyle.plain,
            target: self,
            action: #selector(back(_:))
        )
    }
    

    func back(_ sender:UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
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
                var venueInfoViewModel:VenueCoverViewModel?
                
                let venueForRow:Venue = listData.venueMembers[indexPath.item]
                if let name = venueForRow.name, let type = venueForRow.type?.typeName, let typeDesc = venueForRow.type?.typeDescription, let tagline = venueForRow.tagline, let keyImage = venueForRow.images.first?.imageName {
                    venueInfoViewModel = VenueCoverViewModel(venueName: name, tagline: tagline, venueType: type, typeDescription: typeDesc, keyImageName: keyImage, isOpen: venueForRow.isOpen)
                    
                }
                
               
                
                
                
                
                let venueCell = collectionView.dequeueReusableCell(withReuseIdentifier: storyboardValues.venueCellID, for: indexPath) as! VenueCell
                
                venueCell.viewModel = venueInfoViewModel
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
        
        selectedIndexPath = indexPath
        selectedItem  = collectionView.cellForItem(at: indexPath)
        
        if collectionView.contentOffset.y < offset {
            collectionView.setContentOffset(CGPoint(x: 0, y: offset), animated: true)
        } else {
            fireSegueWithSelectedCell()
        }


    }
    
    /// scroll behaviors (e.g. show / hide nav bar)
    override func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        hideNavBar()
    }
    

//    override func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
//        showNavBar()
//    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        hideNavBar()
    }
    
    override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {

        showNavBar()
    }
    
    override func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        showNavBar()


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
//            print("Sending data as venue")
            let detailController = segue.destination as! VenueDetailViewController
            let selectedVenue = sender as! Venue
            detailController.itemData = selectedVenue
            
 
            
        }
    }
    
   
    
}

//extension CatalogListCollectionViewController : ZoomingPhotoController {
//
//    
//    
//    func heroImage(for transition:ZoomingPhotoTransition) -> UIImageView? {
//        
//        if let selectedIndexPath = selectedIndexPath {
//            let cell = collectionView?.cellForItem(at: selectedIndexPath) as! VenueCell
//            return cell.venueImage
//            
//        } else {
//            return nil
//        }
//    }
//    
//    
//    func gradient(for transition: ZoomingPhotoTransition) -> GradientView? {
//        if let selectedIndexPath = selectedIndexPath {
//            let cell = collectionView?.cellForItem(at: selectedIndexPath) as! VenueCell
//            return cell.gradientView
//        } else {
//            return nil
//        }
//        
//    }
//    
//    func infoPanel(for transition: ZoomingPhotoTransition) -> UIView? {
//        if let selectedIndexPath = selectedIndexPath {
//            let cell = collectionView?.cellForItem(at: selectedIndexPath) as! VenueCell
//            return cell.venueInfo
//        } else {
//            return nil
//        }
//    }
//    
//}

// showing hiding status bar
extension CatalogListCollectionViewController  {
    
    func hideNavBar() {
        
        
        guard let navController = self.navigationController else { return }
        let navBarFrame:CGRect = navController.navigationBar.frame
        
        
        
        UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseInOut, animations: {
            
            
            navController.navigationBar.alpha = 0.0
        }, completion: {
            ( completed ) in
            
            navController.navigationBar.frame = CGRect.zero
            navController.navigationBar.frame = navBarFrame
//            navController.navigationBar.frame = CGRect(x: 0, y: 20, width: navBarFrame.size.width, height: 44)
            self.statusBarHidden = true
            
            
            
        })
        
        
    }
    
    func showNavBar() {
        
        
        
        guard let navController = self.navigationController else { return }
        let navBarFrame:CGRect = navController.navigationBar.frame
        
        
        
        
        UIView.animate(withDuration: 0.33, delay: 1.0, options: .curveEaseInOut, animations: {
            
            
            
            navController.navigationBar.alpha = 1.0
        }, completion: {
            ( completed ) in
            navController.navigationBar.frame = CGRect.zero
            navController.navigationBar.frame = navBarFrame
//            navController.navigationBar.frame = CGRect(x: 0, y: 20, width: navBarFrame.size.width, height: 44)
            self.statusBarHidden = false
            
        })
        
        
        
        
    }
    
    override var prefersStatusBarHidden: Bool {
        return statusBarHidden
    }
   
}
