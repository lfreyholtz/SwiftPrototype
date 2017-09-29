//
//  DescriptionCellTableViewCell.swift
//  myAIDADynamicPrototype
//
//  Created by LewFreyholtz on 9/28/17.
//  Copyright © 2017 Lew Freyholtz. All rights reserved.
//

import UIKit


@IBDesignable class DescriptionCellTableViewCell: UITableViewCell {

    @IBOutlet var articleTitle: AdvancedLabel!
    @IBOutlet var articleBody: UITextView!
    
    
    
    static var identifier: String {
        return String(describing: self)
    }
    
    
    // retrieve item from view model
    var article:VenueDetailModelItem? {
        didSet {
            
            guard let article = article as? VenueDetailModelArticleItem else { return }
            self.articleTitle.text = article.title
            self.articleTitle.addTextSpacing()
            self.articleBody.text = article.body
            
            self.articleBody.translatesAutoresizingMaskIntoConstraints = true
            self.articleBody.sizeToFit()
            
            // TODO: Author
            
        }
    }
    
    
//    var venueArticle:Venue? {
//        didSet {
//            
//            guard let venueArticle = venueArticle else { return }
//            self.articleTitle.text = venueArticle.tagline
//            self.articleTitle.addTextSpacing()
//            
//            self.articleBody.text = venueArticle.articleText
//            self.articleBody.translatesAutoresizingMaskIntoConstraints = true
//            self.articleBody.sizeToFit()
//            
//        }
//    }
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.articleBody.textContainerInset = UIEdgeInsets.zero
        self.articleBody.textContainer.lineFragmentPadding = 0
        
        
    }

    
    
}
