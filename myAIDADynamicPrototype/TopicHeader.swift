//
//  TopicHeader.swift
//  myAIDADynamicPrototype
//
//  Created by Lew Freyholtz on 27.06.17.
//  Copyright © 2017 Lew Freyholtz. All rights reserved.
//

import UIKit

class TopicHeader: UICollectionReusableView {
    
    @IBOutlet weak var gradientView: GradientView!
    @IBOutlet weak var topicImage: UIImageView!
    @IBOutlet weak var topicTitle: AdvancedLabel!
    @IBOutlet weak var topicSubheading: UILabel!
    
    var topic:Topic? {
        didSet {
            if let topic = topic {
                topicImage.image = UIImage(named: topic.topicImage!, in: Bundle.main, compatibleWith: nil)
                topicSubheading.text = topic.tagline
                let titleText = topic.title?.uppercased()
                topicTitle.text = titleText
                topicTitle.addTextSpacing()

            }
        }
    }
}
