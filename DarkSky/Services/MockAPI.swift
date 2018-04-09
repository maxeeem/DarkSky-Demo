//
//  MockAPI.swift
//  DarkSky
//
//  Created by Maxim VT on 4/9/18.
//  Copyright © 2018 Sample. All rights reserved.
//

import Foundation

class MockAPI: API {
    var days: [Day]
    
    init(days: [Day]) {
        self.days = days
    }
    
    func getForecast(_ success: @escaping ([Day]) -> (), failure: @escaping () -> ()) {
        success(days)
    }
    
}
