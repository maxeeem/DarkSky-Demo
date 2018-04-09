//
//  Day.swift
//  DarkSky
//
//  Created by Maxim VT on 4/7/18.
//  Copyright © 2018 Sample. All rights reserved.
//

import Foundation
import UIKit

struct Day: Decodable {
    let time: Date
    let summary: String?
    private let icon: String?
    private let temperatureHigh: Double?
    private let temperatureLow: Double?
    private let humidity: Double?
    private let windSpeed: Double?
}

extension Day {
    var title: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, MMM d"
        return Calendar.current.isDateInToday(time) ? "Today" : formatter.string(from: time)
    }
    
    var titleColor: UIColor {
        return Calendar.current.isDateInToday(time) ? .blue : .black
    }
    
    var high: String {
        return "\(Int(temperatureHigh ?? 0))℉"
    }
    
    var low: String {
        return "\(Int(temperatureLow ?? 0))℉"
    }
    
    var emoji: String {
        guard let icon = icon else {
            return "🌎"
        }
        
        switch icon {
        case "clear-day", "clear-night":
            return "☀️"
        case "rain":
            return "🌧"
        case "snow", "sleet":
            return "🌨"
        case "wind":
            return "💨"
        case "fog":
            return "🌫"
        case "cloudy":
            return "☁️"
        case "partly-cloudy-day", "partly-cloudy-night":
            return "⛅️"
        default:
            return "🌎"
        }
    }
    
    var humidityPercent: String? {
        guard let humidity = humidity else {
            return nil
        }
        return "\(Int(humidity*100))%"
    }
    
    var wind: String? {
        guard let windSpeed = windSpeed else {
            return nil
        }
        return "\(Int(windSpeed)) mph"
    }
    
}

