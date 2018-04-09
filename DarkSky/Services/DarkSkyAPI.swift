//
//  DarkSkyAPI.swift
//  DarkSkyAPI
//
//  Created by Maxim VT on 4/8/18.
//  Copyright © 2018 Sample. All rights reserved.
//

import Foundation

protocol API {
    /// using promises here could give us cleaner code and possibility of chaining
    func getForecast(_ success: @escaping ([Day])->(), failure: @escaping ()->())
}

class DarkSkyAPI: API {
    /// ideally api key should be in a separate file
    /// not checked into source control
    let secret = "8e993f3d8d3556c59211469893db9541"
    let baseUrl = "https://api.darksky.net/forecast"
    let location = "32.715736,-117.161087"
    
    func getForecast(_ success: @escaping ([Day])->(), failure: @escaping ()->()) {
        var urlString = [baseUrl, secret, location].joined(separator: "/")
        urlString += "?exclude=[currently,minutely,hourly,alerts,flags]"
        let url = URL(string: urlString)!

        URLSession.shared.dataTask(with: url) { (data, _, _) in
            /// since we're only coding for `happy paths`
            /// we aren't checking for the correct response code
            /// or the presence of errors
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .secondsSince1970
                    let forecast = try decoder.decode(Forecast.self, from: data)
                    let days = forecast.daily.data
                    
                    /// call `success` handler
                    success(days)
                    
                } catch {
                    failure()
                }
            } else {
                failure()
            }
        }.resume()
    }
}
