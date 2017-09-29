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
    

    var itemData:Object?
    
    var statusBarHidden:Bool = false {
        didSet {
            self.setNeedsStatusBarAppearanceUpdate()
        }
    }

    
    // TODO: Put these somewhere useful so they can be used for all detail types
    var sections = [
        DetailSection(title: "ÖFFNUNGSZEITEN",
                      icon: UIImage(named:"icn_clock")!,
                      type: "openingTimes",
                      expanded: true),
        
        DetailSection(title: "<LOCATION>",
                      icon: UIImage(named:"icn_clock")!,
                      type: "openingTimes",
                      expanded: true),
        
        DetailSection(title: "INKLUSIVLEISTUNGEN",
                      icon: UIImage(named:"icn_clock")!,
                      type: "openingTimes",
                      expanded: true),
    
    ]
    
    
    @IBOutlet weak var tableView: UITableView!


    private let coverImageHeaderHeight = UIScreen.main.bounds.size.height
    
    @IBOutlet var infoView: UIView!
    @IBOutlet var bookingButton: UIButton!
    
    @IBOutlet var infoViewCenterConstraint: NSLayoutConstraint!
    
    
    
    @IBOutlet weak var alternativesCollectionView: UICollectionView!
    
    
    @IBOutlet weak var descriptionFooterView: UIView!
    @IBOutlet weak var descriptionTitle: UILabel!
    @IBOutlet weak var descriptionText: UITextView!
    @IBOutlet weak var alternativesTitle: UILabel!
    @IBOutlet weak var menuButton: UIButton!
    
    
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

//        fileprivate let viewModel = VenueDetailViewModel(venue:itemData)
        

        
        let headerViewFrame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
        tableView.tableHeaderView?.frame = headerViewFrame
        
        guard let itemData = itemData else { fatalError("No item data") }
        dataType = String(describing: type(of:itemData))
        if let dataType = dataType {
            
            // TODO: Test with other types, consolidate into method
            
            let mainRealm = try! Realm(configuration: RealmConfig.main.configuration)
            let allVenues = mainRealm.objects(Venue.self)
            
            switch dataType {
                case "Venue":
                    print("yup, it's a venue")
                    let itemData = itemData as! Venue
                    let info = infoView as! VenueInfoView
                    info.venue = itemData
                    let viewModel = VenueDetailViewModel(venue:itemData)
                    tableView.dataSource = viewModel
                    self.bookingButton.isHidden = itemData.isBookable.value!
                
                    let footer = self.descriptionFooterView as! VenueFooterView
                    footer.Data = itemData
//                    footer.setCollectionViewDataSourceDelegate(self)
                    footer.alternatives = allVenues
                
                default:
                    fatalError("data type not recognized")
            }
        }
        tableView.estimatedRowHeight = tableView.rowHeight
        tableView.rowHeight = UITableViewAutomaticDimension
        
        
        
        

        
//        descriptionText!.delegate = self
        
        
        tableView.register(UINib(nibName:"expandableHeaderView", bundle:nil), forHeaderFooterViewReuseIdentifier: "expandingHeader")
        
        
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
       
    }
    
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//        
//        guard let footerView = tableView.tableFooterView else {
//            return
//        }
//        
//        let size = footerView.systemLayoutSizeFitting(UILayoutFittingCompressedSize)
//        if footerView.frame.size.height != size.height {
//            footerView.frame.size.height = size.height
//        }
//        
//        tableView.tableFooterView = footerView
//        tableView.layoutIfNeeded()
//    }
    
    func back(_ sender:UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
  
}

//extension VenueDetailViewController:UITableViewDataSource {
//    
//    
//    func numberOfSections(in tableView: UITableView) -> Int {
//        print(sections.count)
//        return sections.count
//    }
//    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 1
//    }
//    
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 44
//    }
//    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        if (sections[indexPath.section].expanded) {
//            return 44
//        } else {
//            return 0
//        }
//    }
//    
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        
//        let sectionHeader = tableView.dequeueReusableHeaderFooterView(withIdentifier: "expandingHeader") as! ExpandableHeader
//        sectionHeader.customInit(title: sections[section].title,
//                              section: section,
//                              icon: sections[section].icon!,
//                              delegate: self)
//        
//        return sectionHeader
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "defaultCell")!
//        cell.textLabel?.text = "Placeholder for custom cell depending on type"
//        return cell
//    }
//}


extension VenueDetailViewController : UITableViewDelegate {
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        hideNavBar()
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        hideNavBar()
        let info = infoView as! VenueInfoView
        info.scrollViewDidScroll(scrollView:scrollView)
        
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        showNavBar()
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        showNavBar()
    }
}



extension VenueDetailViewController: ExpandableHeaderViewDelegate {
    
    
    func toggleSection(header: ExpandableHeader, section: Int) {
        
        print("Toggle Header")
//        sections[section].expanded = !sections[section].expanded
//        // implement reload rows here
//        tableView.endUpdates()
    
    }
    
}

//extension VenueDetailViewController : ZoomingPhotoController {
//    
//    func heroImage(for transition: ZoomingPhotoTransition) -> UIImageView? {
//        return self.tableHeaderView.keyImage
//    }
//    
//    func gradient(for transition: ZoomingPhotoTransition) -> GradientView? {
//        return self.tableHeaderView.keyImageGradient
//    }
//    
//    func infoPanel(for transition: ZoomingPhotoTransition) -> UIView? {
//        return self.tableHeaderView.infoStack
//    }
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

func generateRandomData() -> [[UIColor]] {
    let numberOfRows = 20
    let numberOfItemsPerRow = 15
    
    return (0..<numberOfRows).map { _ in
        return (0..<numberOfItemsPerRow).map { _ in UIColor.randomColor() }
    }
}

extension UIColor {
    
    class func randomColor() -> UIColor {
        
        let hue = CGFloat(arc4random() % 100) / 100
        let saturation = CGFloat(arc4random() % 100) / 100
        let brightness = CGFloat(arc4random() % 100) / 100
        
        return UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: 1.0)
    }
}
