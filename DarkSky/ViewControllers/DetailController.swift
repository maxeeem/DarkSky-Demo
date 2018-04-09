//
//  DetailController.swift
//  DarkSky
//
//  Created by Maxim VT on 4/7/18.
//  Copyright © 2018 Sample. All rights reserved.
//

import UIKit

class DetailController: UIViewController {

    var day: Day!
    
    @IBOutlet weak var humidity: UILabel!
    @IBOutlet weak var wind: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = day.title
        
        humidity.text = day.humidityPercent
        wind.text = day.wind
    }

}
