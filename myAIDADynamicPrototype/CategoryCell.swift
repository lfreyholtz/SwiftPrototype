//
//  CategoryCell.swift
//  myAIDADynamicPrototype
//
//  Created by Lew Freyholtz on 27.06.17.
//  Copyright © 2017 Lew Freyholtz. All rights reserved.
//

import UIKit

class CategoryCell: UICollectionViewCell {
    
    @IBOutlet weak var categoryTitle: UILabel!
    @IBOutlet weak var categoryCount: UILabel!
    @IBOutlet weak var categoryDescriptiveText: UILabel!
    
    var category:Category? {
        didSet {
            
            if let category = category {
                categoryTitle.text = category.title.uppercased()
                
                let categoryMemberType = category.memberType
                setValuesfor(category: category, memberType: categoryMemberType)
            }

   
        
        }
    
    
    }
    
    private func setValuesfor(category:Category, memberType:String) {
       
        if memberType == "venue" {
           let members = category.venueMembers
            categoryCount.text = String(members.count)
            if (members.count == 1) {
                categoryDescriptiveText.text = category.subsingle

            } else {
                categoryDescriptiveText.text = category.subtitle
            }
        // TODO: Other value types
            
        }
    }
    
}
