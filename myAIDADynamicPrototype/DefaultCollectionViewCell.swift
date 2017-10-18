//
//  DefaultCollectionViewCell.swift
//  myAIDADynamicPrototype
//
//  Created by Lew Freyholtz on 06.07.17.
//  Copyright © 2017 Lew Freyholtz. All rights reserved.
//

import UIKit

class DefaultCollectionViewCell: UICollectionViewCell {

    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        
        super.apply(layoutAttributes)
//        let standardHeight = PhotoListLayoutConstants.Cell.standardHeight
//        let featuredHeight = PhotoListLayoutConstants.Cell.featuredHeight
        
        
    }
    static var identifier: String {
        return String(describing: self)
    }
    
    static var nib:UINib {
        return UINib(nibName: identifier, bundle: nil)
    }

}
