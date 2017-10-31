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
    
    
    // testing views
    
    
    var listData:Category? {
        didSet {
            self.viewModel = PhotoListViewModel(category: listData)
            self.collectionView?.delegate = viewModel
            
            viewModel?.performSegue = {[weak self] (selectedItem) in
               
                self?.performSegue(withIdentifier: "detailSegue", sender: selectedItem)
                
                
            }
            // callback to refresh collectionView
            viewModel?.refreshCollection = { [weak self]  in
                let indexSet = IndexSet(integer: 0)
                self?.collectionView?.performBatchUpdates({ () -> Void in
                    self?.collectionView?.reloadSections(indexSet)
                }, completion: nil)
//                print("Collection data reloaded")
            }

            
        }
    }
    
    var viewModel: PhotoListViewModel?

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
        collectionView!.isPrefetchingEnabled = false
        collectionView!.dataSource = viewModel
        
        
        
        
        // Register cell classes
        collectionView!.register(VenueCell.nib, forCellWithReuseIdentifier: VenueCell.identifier)
        collectionView!.register(DefaultCollectionViewCell.nib, forCellWithReuseIdentifier:DefaultCollectionViewCell.identifier)
        
        
        // custom back icon
        let icon = UIImage(named:"icn_back_white")
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: icon,
            style: UIBarButtonItemStyle.plain,
            target: self,
            action: #selector(back(_:))
        )
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let detailController = segue.destination as! VenueDetailViewController
        detailController.itemData = sender as? Object
        
    }


    func back(_ sender:UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
    



}




// MARK: UICollectionViewDelegate

//    
//    /// scroll behaviors (e.g. show / hide nav bar)
//    override func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
//        hideNavBar()
//    }
//    
//
//
//    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        hideNavBar()
//    }
//    
//    override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
//
//        showNavBar()
//    }
//    
//    override func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
//        showNavBar()
//
//
//        perform(#selector(fireSegueWithSelectedCell), with: nil, afterDelay: 0.3)
//    }
    
//    func fireSegueWithSelectedCell(){
//        if let selectedIndexPath = selectedIndexPath {
//            
//            if let listData = listData {
//                
//                let dataType = listData.memberType
//                
//                switch dataType {
//                    
//                case "venue":
//                    let venue = listData.venueMembers[selectedIndexPath.item]
//                    performSegue(withIdentifier: segueForDetail, sender: venue)
//                    
//                default:
//                    break
//                }
//            }
//        }
//    
//    }
//    
//    

//    

    
//}

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
