//
//  RatingsStackView.swift
//  myAIDADynamicPrototype
//
//  Created by LewFreyholtz on 10/18/17.
//  Copyright © 2017 Lew Freyholtz. All rights reserved.
//

import UIKit

@IBDesignable class RatingsStackView: UIStackView {

    private var ratingStars = [UIImageView]()
    
    @IBInspectable var starSize: CGSize = CGSize(width: 11.0, height: 11.0) {
        didSet {
            setupStars()
        }
    }
    
    @IBInspectable var starCount: Int = 5 {
        didSet{
            setupStars()
        }
    }

    var rating = 1 {
        didSet {
            updateSelectionStates()
        }
    }
    
    override init(frame:CGRect) {
        super.init(frame:frame)
        setupStars()
    }
    
    required init(coder:NSCoder) {
        super.init(coder:coder)
        setupStars()
        
    }
    
    private func setupStars() {
        
        for starItem in ratingStars {
            removeArrangedSubview(starItem)
            starItem.removeFromSuperview()
        }
        
        ratingStars.removeAll()
        
        for _ in 0..<starCount {
            
            let star = UIImageView()
            star.image = UIImage(named: "icn_star")
            star.contentMode = .scaleAspectFill
//            star.backgroundColor = UIColor.red
            star.translatesAutoresizingMaskIntoConstraints = false
            star.heightAnchor.constraint(equalToConstant: starSize.height).isActive = true
            star.widthAnchor.constraint(equalToConstant: starSize.width).isActive = true
            
            let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(ratingItemTapped(_:)))
            star.addGestureRecognizer(tapRecognizer)
            star.isUserInteractionEnabled = true
            
            addArrangedSubview(star)
            ratingStars.append(star)
            
        }
        updateSelectionStates()
    }
    
    func ratingItemTapped(_ sender:UITapGestureRecognizer) {
        print("rating item tapped 👍")
    }
    

    private func updateSelectionStates() {
        for (index, star) in ratingStars.enumerated() {
            star.tintColor = nil
            if index < rating {
                star.tintColor = UIColor(red: CGFloat(251/255.0), green: CGFloat(199/255.0), blue: CGFloat(21/255.0), alpha: 1.0)
            } else {
                star.tintColor = UIColor(red: CGFloat(236/255.0), green: CGFloat(236/255.0), blue: CGFloat(236/255.0), alpha: 1.0)
            }
        }
    }
}
