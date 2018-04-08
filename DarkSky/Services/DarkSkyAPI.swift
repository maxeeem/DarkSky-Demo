//
//  DarkSkyAPI.swift
//  DarkSkyAPI
//
//  Created by Maxim VT on 4/8/18.
//  Copyright © 2018 Sample. All rights reserved.
//

import Foundation

protocol API {
    func getForecast(_ completion: ([Day]) -> ())
}

class DarkSkyAPI: API {
    /// ideally api key should be in a separate file
    /// not checked into source control
    let secret = "8e993f3d8d3556c59211469893db9541"
    let baseUrl = "https://api.darksky.net/forecast"
    let location = "32.715736,-117.161087"
    
    func getForecast(_ completion: ([Day]) -> ()) {
        let urlString = [baseUrl, secret, location].joined(separator: "/")
        let url = URL(string: urlString)!
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data, let json = String(data: data, encoding: .utf8) {
                print(json)
            }
        }.resume()
    }
}
