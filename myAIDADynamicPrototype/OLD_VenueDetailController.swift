//
//  VenueDetailController.swift
//  myAIDADynamicPrototype
//
//  Created by Lew Freyholtz on 31.07.17.
//  Copyright © 2017 Lew Freyholtz. All rights reserved.
//

import UIKit

class VenueDetailController: UIViewController {

    
    // Venue Meta
    @IBOutlet weak var venueTitle: UILabel!
    @IBOutlet weak var venueKeyImage: UIImageView!
    @IBOutlet weak var buyButton: UIButton!
    
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    // Opening Times
    @IBOutlet weak var openingTimesTitle: AdvancedLabel!
    @IBOutlet weak var openingTimesIcon: UIImageView!
    @IBOutlet weak var openingTimesDisclosure: UIImageView!
    @IBOutlet weak var openingTimesHeight: NSLayoutConstraint!
    
    
    // Location
    @IBOutlet weak var locationTitle: AdvancedLabel!
    @IBOutlet weak var locationIcon: UIImageView!
    @IBOutlet weak var locationDisclosure: UIImageView!
    @IBOutlet weak var locationHeightConstraint: NSLayoutConstraint!
    
    
    // What's Included
    @IBOutlet weak var whatsIncludedTitle: AdvancedLabel!
    @IBOutlet weak var whatsIncludedIcon: UIImageView!
    @IBOutlet weak var whatsIncludedDisclosure: UIImageView!
    @IBOutlet weak var whatsIncludedHeightConstraint: NSLayoutConstraint!
    
    
    // Capacity 
    @IBOutlet weak var capacityIcon: UIImageView!
    @IBOutlet weak var capacityTitle: AdvancedLabel!
    @IBOutlet weak var capacityDisclosure: UIImageView!
    @IBOutlet weak var capacityHeightConstraint: NSLayoutConstraint!
    
    //Actions
    @IBAction func reserveVenue(_ sender: Any) {
    }
    
    
    var venue:Venue?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        venueKeyImage.frame.size.width = UIScreen.main.bounds.size.width
        
        if let venue = venue {
            
            venueTitle.text = venue.name
            let keyImage = venue.images.first?.imageName
            
            if keyImage != nil {
                venueKeyImage.image = UIImage(named: keyImage!, in: Bundle.main, compatibleWith: nil)
                
            }
            
            
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        scrollView.delegate = self


        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    



}

//extension VenueDetailController : UIScrollViewDelegate {
//    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        <#code#>
//    }
//}
