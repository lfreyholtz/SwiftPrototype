//
//  VenueFooterView.swift
//  myAIDADynamicPrototype
//
//  Created by LewFreyholtz on 9/28/17.
//  Copyright © 2017 Lew Freyholtz. All rights reserved.
//

import UIKit
import RealmSwift


class VenueFooterView: UIView {

    @IBOutlet var detailDescription: UITextView!
    @IBOutlet var detailTitle: AdvancedLabel!
    @IBOutlet fileprivate weak var collectionView: UICollectionView!
    
    @IBOutlet var contentView: UIView!
    var alternatives:Results<Venue>?
    
    struct storyboardValues {
        static let venueCellID = "venueCell"
        static let venueCellNibName = "VenueCell"
        static let defaultCellID = "defaultCell"
        static let venueDetailSegue = "venueDetailSegue"
        
        
    }
    
    var Data:Venue? {
        didSet {
            if let Data = Data {
                print("Setting data in footer view")
                self.detailDescription.text = Data.articleText
                self.detailDescription.translatesAutoresizingMaskIntoConstraints = true
                self.detailDescription.sizeToFit()
//                self.detailDescription.isScrollEnabled = false
                
                self.detailTitle.text = Data.tagline
                self.detailTitle.addTextSpacing()
            }
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
        
    }
    
    required init?(coder aDecoder:NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override func layoutIfNeeded() {
        super.layoutIfNeeded()
    }
    
    
    private func commonInit() {
        let bundle:Bundle = Bundle(for: type(of: self))
        
        bundle.loadNibNamed("VenueFooterView", owner: self, options: nil)
        addSubview(contentView)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        contentView.layoutSubviews()
        contentView.updateConstraints()
        
        // register collectionView cells
        collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: storyboardValues.defaultCellID)
        collectionView!.register(UINib(nibName: storyboardValues.venueCellNibName, bundle: nil), forCellWithReuseIdentifier: storyboardValues.venueCellID)

    }
    
    func setCollectionViewDataSourceDelegate<D: UICollectionViewDataSource & UICollectionViewDelegate>(_ dataSourceDelegate: D) {

        
        collectionView.delegate = dataSourceDelegate
        collectionView.dataSource = dataSourceDelegate
        collectionView.reloadData()
    }


}

extension VenueFooterView : UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        self.contentView.layoutIfNeeded()
    }
}

extension VenueFooterView : UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let alternatives = alternatives {
            return alternatives.count
        } else {
            print("no list supplied")
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let alternatives = alternatives {
            let itemCell = collectionView.dequeueReusableCell(withReuseIdentifier: storyboardValues.venueCellID, for: indexPath) as! VenueCell
            itemCell.venue = alternatives[indexPath.item]
            return itemCell
        } else {
            let defaultCell = collectionView.dequeueReusableCell(withReuseIdentifier: storyboardValues.defaultCellID, for: indexPath) as! DefaultCollectionViewCell
        
            return defaultCell
        }
        
    }
}
