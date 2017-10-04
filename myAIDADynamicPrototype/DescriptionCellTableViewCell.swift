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
    
    static var nib:UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    // retrieve item from view model
    var article:VenueDetailModelItem? {
        didSet {
            
            guard let article = article as? VenueDetailModelArticleItem else { return }
            self.articleTitle.text = article.title
            self.articleTitle.addTextSpacing()
            self.articleBody.text = article.body
            self.articleBody.textContainerInset = UIEdgeInsets.zero
            self.articleBody.textContainer.lineFragmentPadding = 0
//            self.articleBody.translatesAutoresizingMaskIntoConstraints = true
//            self.articleBody.sizeToFit()
            
            // TODO: Author
            
        }
    }
    


    override func awakeFromNib() {
        super.awakeFromNib()
        print("initializing article cell - awake from nib")
        // Initialization code
        
    }



    
    
}

