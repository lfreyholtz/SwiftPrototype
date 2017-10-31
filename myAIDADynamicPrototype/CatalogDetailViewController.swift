//
//  CatalogDetailViewController.swift
//  myAIDADynamicPrototype
//
//  Created by LewFreyholtz on 10/31/17.
//  Copyright © 2017 Lew Freyholtz. All rights reserved.
//

import UIKit
import RealmSwift


class CatalogDetailViewController: UIViewController {

   
    var venues:Results<Venue>!
    
    var infoViewModel:VenueCoverViewModel?
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
//    let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let mainRealm = try! Realm(configuration: RealmConfig.main.configuration)
        venues = mainRealm.objects(Venue.self)
        let testVenue = venues.first
        if testVenue != nil {
            infoViewModel = VenueCoverViewModel(venue:testVenue!)
        }
        
        collectionView.register(CatalogDetailHeader.nib, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: CatalogDetailHeader.identifier)
        
        

        
//        let testVenue = mainRealm.objects(Venue.self).first
//        if let testVenue = testVenue {
//            infoViewModel = VenueCoverViewModel(venue:testVenue)
//        }
        
      
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    



}

extension CatalogDetailViewController : UICollectionViewDataSource {
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionElementKindSectionHeader:
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: CatalogDetailHeader.identifier, for: indexPath) as! CatalogDetailHeader
            headerView.venueDetail.viewModel = infoViewModel
            
            return headerView
        default:
            assert(false, "unexpected element kind")
        }
    }
}
