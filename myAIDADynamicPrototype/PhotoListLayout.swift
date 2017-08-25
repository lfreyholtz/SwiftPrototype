//
//  PhotoListLayout.swift
//  myAIDADynamicPrototype
//
//  Created by Lew Freyholtz on 06.07.17.
//  Copyright © 2017 Lew Freyholtz. All rights reserved.
//

import Foundation
import UIKit


struct PhotoListLayoutConstants {
    struct Cell {
        
        /* The height of the non-featured cell */
        static let standardHeight: CGFloat = 120
        /* The height of the first visible cell */
        static let featuredHeight: CGFloat = 400
//        var featuredHeight:CGFloat = 400
        static let fullScreenHeight:CGFloat = UIScreen.main.bounds.height
    }
}

class PhotoListLayout:UICollectionViewLayout{
//    var standardHeight:CGFloat = 120
//    var featuredHeight:CGFloat = 400
    
    // MARK: Properties and Variables
//    var featuredHeight:CGFloat = 400
    // The amount the user needs to scroll before the featured cell changes
    let dragOffset:CGFloat = UIScreen.main.bounds.size.height / 3
//    let dragOffset: CGFloat = 180.0
    
    var cache = [UICollectionViewLayoutAttributes]()
    
    // Returns the item index of the currently featured cell
    var featuredItemIndex: Int {
        get {
            // Use max to make sure the featureItemIndex is never < 0
            return max(0, Int(collectionView!.contentOffset.y / dragOffset))
        }
    }
    
    
    
    // Returns a value between 0 and 1 that represents how close the next cell is to becoming the featured cell
    var nextItemPercentageOffset: CGFloat {
        get {
            return (collectionView!.contentOffset.y / dragOffset) - CGFloat(featuredItemIndex)
        }
    }
    
    var width: CGFloat {
        get {
            return collectionView!.bounds.width
        }
    }
    
    var height: CGFloat {
        get {
            return collectionView!.bounds.height
        }
    }
    
    var numberOfItems: Int {
        get {
            return collectionView!.numberOfItems(inSection: 0)
        }
    }
    
    // MARK: UICollectionViewLayout
    
    // Return the size of all the content in the collection view
    override var collectionViewContentSize: CGSize{
        let contentHeight = (CGFloat(numberOfItems) * dragOffset) + (height - dragOffset)
        return CGSize(width: width, height: contentHeight)
    }
    
    override func prepare() {
        
        cache.removeAll(keepingCapacity: false)
        let standardHeight = PhotoListLayoutConstants.Cell.standardHeight
        let featuredHeight = PhotoListLayoutConstants.Cell.featuredHeight
        
        var frame = CGRect.zero
        var y: CGFloat = 0
        
        for item in 0..<numberOfItems {
            let indexPath = IndexPath(item:item, section:0)
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            let scrollOffset = collectionView!.contentOffset
            
            // switch z index on all items so that they are stacked in the opposite order
            attributes.zIndex = item
            var height = standardHeight
            
        
            // determine which item should transition, which one to feature, which ones to show as standard
            
            if indexPath.item == featuredItemIndex {
                let yOffset = (standardHeight * nextItemPercentageOffset)
                y = collectionView!.contentOffset.y - yOffset
                
                // sticky header
                if (scrollOffset.y < 0) {
                    let deltaY = fabs(scrollOffset.y)
                    height = max(0, featuredHeight + deltaY)
                    y = frame.minY - deltaY
                    
                } else {
                    height = featuredHeight
                }
                
            } else if indexPath.item == (featuredItemIndex + 1) && indexPath.item != numberOfItems {
                let maxY = y + standardHeight
                height = standardHeight + max((featuredHeight - standardHeight) * nextItemPercentageOffset, 0)
                y = maxY - height
            }
            
            
            frame = CGRect(x: 0, y: y, width: width, height: height)
            attributes.frame = frame
            cache.append(attributes)
            y = frame.maxY
            
            
            
        }
    
    }
    
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var layoutAttributes = [UICollectionViewLayoutAttributes]()
        
  
        for attributes in cache {
            if attributes.frame.intersects(rect) {
                layoutAttributes.append(attributes)
            }
        }
        return layoutAttributes
    }
    
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return cache[indexPath.item]
    }

    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
    
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        
            let proposedPageIndex = round(proposedContentOffset.y / dragOffset) // not snapping effectively; TODO: dragOffset / 2?
        
            let nearestPageIndex = proposedPageIndex * dragOffset
            return CGPoint(x:0, y:nearestPageIndex)

    }
}
