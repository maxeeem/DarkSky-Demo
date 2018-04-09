//
//  Forecast.swift
//  DarkSky
//
//  Created by Maxim VT on 4/9/18.
//  Copyright © 2018 Sample. All rights reserved.
//

import Foundation

struct Forecast: Decodable {
    let daily: Daily
 
    struct Daily: Decodable {
        let summary: String
        let data: [Day]
    }
}
