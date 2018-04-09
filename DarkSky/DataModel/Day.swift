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
    let summary: String
    internal let icon: String
    internal let temperatureHigh: Double
    internal let temperatureLow: Double
    internal let humidity: Double
    internal let windSpeed: Double
    
    enum CodingKeys: String, CodingKey {
        case time = "time"
        case summary = "summary"
        case icon = "icon"
        case temperatureHigh = "temperatureHigh"
        case temperatureLow = "temperatureLow"
        case humidity = "humidity"
        case windSpeed = "windSpeed"
    }
}

extension Day {
    init(time: Date) {
        self.time = time
        self.summary = ""
        self.icon = ""
        self.temperatureHigh = 0
        self.temperatureLow = 0
        self.humidity = 0
        self.windSpeed = 0
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let time = try container.decode(Date.self, forKey: .time)
        let summary = try container.decodeIfPresent(String.self, forKey: .summary) ?? ""
        let icon = try container.decodeIfPresent(String.self, forKey: .icon) ?? ""
        let tempHigh = try container.decodeIfPresent(Double.self, forKey: .temperatureHigh) ?? 0
        let tempLow = try container.decodeIfPresent(Double.self, forKey: .temperatureLow) ?? 0
        let humidity = try container.decodeIfPresent(Double.self, forKey: .humidity) ?? 0
        let windSpeed = try container.decodeIfPresent(Double.self, forKey: .windSpeed) ?? 0
        
        self.init(time: time, summary: summary, icon: icon, temperatureHigh: tempHigh, temperatureLow: tempLow, humidity: humidity, windSpeed: windSpeed)
    }
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
        return "\(Int(temperatureHigh))℉"
    }
    
    var low: String {
        return "\(Int(temperatureLow))℉"
    }
    
    var emoji: String {
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
    
    var humidityPercent: String {
        return "\(Int(humidity*100))%"
    }
    
    var wind: String {
        return "\(Int(windSpeed)) mph"
    }
    
}
