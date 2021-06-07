//
//  DemoAppUITests.swift
//  DemoAppUITests
//
//  Created by Giovanni on 8/6/21.
//

import XCTest

class DemoAppUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testExample() throws {
        let app = XCUIApplication()
        app.launch()

        XCTAssertTrue(app.staticTexts["Hello, world!"].exists)
    }
}
