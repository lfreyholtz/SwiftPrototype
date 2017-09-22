//
//  NavCell.swift
//  myAIDADynamicPrototype
//
//  Created by Lew Freyholtz on 23.06.17.
//  Copyright © 2017 Lew Freyholtz. All rights reserved.
//

import UIKit

class NavCell: UICollectionViewCell {
    
    @IBOutlet weak var navLabel: UILabel!
    var topic: Topic? {
        didSet {
            if let topic = topic {
                navLabel.text = topic.title
                
            }
        }
    }

}
