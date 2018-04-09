//
//  DayCell.swift
//  DarkSky
//
//  Created by Maxim VT on 4/7/18.
//  Copyright © 2018 Sample. All rights reserved.
//

import UIKit

class DayCell: UITableViewCell {
    @IBOutlet weak var emoji: UILabel!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var summary: UILabel!
    @IBOutlet weak var high: UILabel!
    @IBOutlet weak var low: UILabel!
    
    
    func configure(with day: Day) {
        /// set day values
        title.text = day.title
        title.textColor = day.titleColor
        emoji.text = day.emoji
        summary.text = day.summary
        high.text = day.high
        low.text = day.low
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        /// clear view values
        title.text = nil
        emoji.text = "🌎"
        summary.text = nil
        high.text = "℉"
        low.text = "℉"
    }
    
}
