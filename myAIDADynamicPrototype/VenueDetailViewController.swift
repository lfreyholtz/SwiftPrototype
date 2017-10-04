//
//  VenueDetailViewController.swift
//  myAIDADynamicPrototype
//
//  Created by Lew Freyholtz on 09.08.17.
//  Copyright © 2017 Lew Freyholtz. All rights reserved.
//

import UIKit
import RealmSwift
import MXParallaxHeader

let cellIdentifier = "defaultCell"





class VenueDetailViewController: UIViewController {
    
    
    
    struct storyboardValues {
        static let venueCellID = "venueCell"
        static let venueCellNibName = "VenueCell"
        static let defaultCellID = "defaultCell"
        static let venueDetailSegue = "venueDetailSegue"
        
        
    }
    
    var dataType: String?
    
    var viewModel:VenueDetailViewModel?
    var itemData:Object?
    
    var statusBarHidden:Bool = false {
        didSet {
            self.setNeedsStatusBarAppearanceUpdate()
        }
    }

    

    
    
    @IBOutlet weak var tableView: UITableView!


    private let coverImageHeaderHeight = UIScreen.main.bounds.size.height
    @IBOutlet var infoView: UIView!
    @IBOutlet var bookingButton: UIButton!
    

    
    
    // Actions
    @IBAction func openFoodMenu(_ sender: Any) {
        print("open food menu")
    }
    
    @IBAction func openBookingFlow(_ sender:Any) {
        print("open booking flow")
    }
    
    @IBAction func openGallery(_ sender:Any) {
        print("open gallery")
    }
    
    
    
    
    // MARK - VIEW CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()


        

        
        
        tableView.estimatedRowHeight = 60.0
        tableView.rowHeight = UITableViewAutomaticDimension
        
        // register cell types
        tableView.register(DescriptionCellTableViewCell.nib, forCellReuseIdentifier: DescriptionCellTableViewCell.identifier)
        tableView.register(LocationTableViewCell.nib, forCellReuseIdentifier: LocationTableViewCell.identifier)
        tableView.register(IncludedTableViewCell.nib, forCellReuseIdentifier: IncludedTableViewCell.identifier)

        tableView.register(ExpandableHeader.nib, forHeaderFooterViewReuseIdentifier: ExpandableHeader.identifier)
        
        // register section header types
        let headerViewFrame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
        
        // UITableView Header
        tableView.tableHeaderView?.frame = headerViewFrame
        
        
        // data switch
        guard let itemData = itemData else { fatalError("No item data") }
        dataType = String(describing: type(of:itemData))

        
        if let dataType = dataType {
            
            
            switch dataType {
                case "Venue":
                    print("yup, it's a venue")
                    let itemData = itemData as! Venue

                    viewModel = VenueDetailViewModel(venue:itemData)
                    tableView.dataSource = viewModel
                    tableView.delegate = viewModel
                    
                    let info = infoView as! VenueInfoView
                    info.viewModel = viewModel?.headerInfoModel
                    
                    // for collapse / expand headers
                    viewModel?.reloadSections = { [weak self] (section: Int) in
                        print("Fire reload sections")
                        self?.tableView?.beginUpdates()
                        self?.tableView?.reloadSections([section], with: .fade)
                        self?.tableView?.endUpdates()
                    }
        
                    
                    
                    self.bookingButton.isHidden = itemData.isBookable.value!
                default:
                    fatalError("data type not recognized")
            }
        }

        

        
        

        
        // custom back icon
        let icon = UIImage(named:"icn_back_white")
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: icon,
            style: UIBarButtonItemStyle.plain,
            target: self,
            action: #selector(back(_:))
        )
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
    }

    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(false)
        tableView.reloadData()
    }
    

    func back(_ sender:UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
  
}



//extension VenueDetailViewController : UITableViewDelegate {
//    
// 
//    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
//        hideNavBar()
//    }
//    
//    
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        hideNavBar()
//        let info = infoView as! VenueInfoView
//        info.scrollViewDidScroll(scrollView:scrollView)
//        
//    }
//    
//    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
//        
//        showNavBar()
//    }
//    
//    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
//        showNavBar()
//    }
//    
////    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
////        return UITableViewAutomaticDimension
////    }
//}








// show hide status bar and nav bar
extension VenueDetailViewController {
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


