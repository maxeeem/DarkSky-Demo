//
//  API.swift
//  DarkSky
//
//  Created by Maxim VT on 4/9/18.
//  Copyright © 2018 Sample. All rights reserved.
//

import Foundation

protocol API {
    /// using promises here could give us cleaner code and possibility of chaining
    func getForecast(_ success: @escaping ([Day])->(), failure: @escaping ()->())
}
