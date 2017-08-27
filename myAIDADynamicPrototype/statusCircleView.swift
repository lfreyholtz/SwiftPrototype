//
//  statusCircleView.swift
//  myAIDADynamicPrototype
//
//  Created by LewFreyholtz on 10/18/17.
//  Copyright © 2017 Lew Freyholtz. All rights reserved.
//

import UIKit

@IBDesignable class statusCircleView: UIView {


    
    override public func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = min((0.5 * bounds.size.width), (0.5 * bounds.size.height))
        self.clipsToBounds = true
    }
    


}
