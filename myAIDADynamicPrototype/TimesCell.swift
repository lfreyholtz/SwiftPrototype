//
//  TimesCell.swift
//  myAIDADynamicPrototype
//
//  Created by LewFreyholtz on 8/27/17.
//  Copyright © 2017 Lew Freyholtz. All rights reserved.
//

import UIKit

class TimesCell: UITableViewCell {


    @IBOutlet weak var todayLabel: UILabel!
    @IBOutlet weak var todayTimes: UILabel!
    
    @IBOutlet weak var tomorrowLabel: UILabel!
    @IBOutlet weak var tomorrowTimes: UILabel!
    
    static var identifier: String {
        return String(describing: self)
    }
    
    static var nib:UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    

    var openingHours:VenueDetailModelItem? {
    
        didSet{
            guard let openingHours = openingHours as? VenueDetailModelOpeningTimesItem else { return }
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "HH:mm"
            
            let hoursToday = openingHours.todaysHours
            var hoursTodayTimesString:String = ""
            if hoursToday.count > 0 {
                todayLabel.text = "Heute"
                for hourEntry in hoursToday {
                    hoursTodayTimesString.append("\(dateFormatter.string(from: hourEntry.opening!)) - \(dateFormatter.string(from: hourEntry.closing!))\n")
                }
                todayTimes.text = hoursTodayTimesString
            } else {
                // maybe get the next hours it's open
                hoursTodayTimesString = "Geschlossen"
            }
            
            
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
