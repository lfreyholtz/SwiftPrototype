//
//  VenueDetailViewController.swift
//  myAIDADynamicPrototype
//
//  Created by Lew Freyholtz on 09.08.17.
//  Copyright © 2017 Lew Freyholtz. All rights reserved.
//

import UIKit
import RealmSwift


let cellIdentifier = "defaultCell"





class VenueDetailViewController: UIViewController {

    

    
//    var venue:Venue?
    var itemData:Venue? {
        didSet {
            let objectType = String(describing: type(of: itemData))
            print(objectType)
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
    
    
    
    
    
    @IBOutlet weak var alternativesCollectionView: UICollectionView!
    
    
    @IBOutlet weak var descriptionFooterView: UITableViewHeaderFooterView!
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
        

        tableView.estimatedRowHeight = tableView.rowHeight
        tableView.rowHeight = UITableViewAutomaticDimension
        
        
//        tableHeaderView = self.coverImageHeader!
        
        descriptionText!.delegate = self
        
        
        tableView.register(UINib(nibName:"expandableHeaderView", bundle:nil), forHeaderFooterViewReuseIdentifier: "expandingHeader")
        
        tableView.backgroundColor = UIColor.orange
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        
//        if let venue = venue {
////            coverImageHeader.venue = venue
//            
//            // TODO: Move to footer view
//            descriptionText.text = venue.articleText
//            descriptionTitle.text = venue.tagline
//            
//            
//            
//        }
        
        

    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(false)
       
    }
    

  
}

extension VenueDetailViewController:UITableViewDataSource {
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (sections[indexPath.section].expanded) {
            return 44
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let sectionHeader = tableView.dequeueReusableHeaderFooterView(withIdentifier: "expandingHeader") as! ExpandableHeader
        sectionHeader.customInit(title: sections[section].title,
                              section: section,
                              icon: sections[section].icon!,
                              delegate: self)
        
        return sectionHeader
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "defaultCell")!
        cell.textLabel?.text = "Placeholder for custom cell depending on type"
        return cell
    }
}


extension VenueDetailViewController : UITableViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        let headerView = self.tableView.tableHeaderView as! VenueCoverView
//        coverImageHeader.scrollViewDidScroll(scrollView: scrollView)
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

extension VenueDetailViewController : UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        print("textDidChange")
        self.tableView.beginUpdates()
        self.tableView.endUpdates()
    }
}
