//
//  PokedexUITests.swift
//  PokedexUITests
//
//  Created by Pablo Trindade on 15/06/19.
//  Copyright © 2019 CWI Software. All rights reserved.
//

import XCTest

class PokedexUITests: XCTestCase {
    var app: XCUIApplication!
    
    override func setUp() {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments = ["UITests"]
        app.launch()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        let cells = app.descendants(matching: .cell)
        let firstCell = cells.firstMatch
        firstCell.tap()
        
        XCTAssertTrue(app.otherElements["detailsView"].waitForExistence(timeout: 1.0))
    }

}
