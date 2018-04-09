//
//  DarkSkyTests.swift
//  DarkSkyTests
//
//  Created by Maxim VT on 4/7/18.
//  Copyright © 2018 Sample. All rights reserved.
//

import XCTest
@testable import DarkSky

class DarkSkyTests: XCTestCase {
    
    func testEmptyForecast() {
        let mockAPI = MockAPI(days: [])
        let main = MainController(api: mockAPI)
        
        main.refreshData()
        
        XCTAssertTrue(main.days.isEmpty)
    }
    
    func testNonEmptyForecast() {
        let day = Day(time: Date())
        let mockAPI = MockAPI(days: [day])
        let main = MainController(api: mockAPI)
        
        main.refreshData()
        
        XCTAssertTrue(main.days.count == 1)
    }
    
    func testDetailController() {
        let day = Day(time: Date())
        let detail = DetailController(day: day)
        
        detail.viewDidLoad()
        
        XCTAssertTrue(detail.title == "Today")
    }
    
}
