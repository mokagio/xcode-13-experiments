// In the release notes:
//
// A new transparent screen overlay indicates the activity while automation is running, and displays text describing how to stop the automation. If you interact with the device while automation is running, the overlay fades away to allow you to better see the screen contents. This new behavior is present in macOS 12, iOS 15, tvOS 15, and watchOS 8.
//
// In macOS, or when using automation on devices with a password, you must run the automation from an admin account, and must authenticate to authorize the automation. This authorization is cached for eight hours. You no longer need to authorize the Xcode Helper app to use Accessibility when running in macOS 12. (71297492)
//
// I wrote this test to see if I could see that overlay, but I don't

import XCTest

class DemoMacAppUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testExample() throws {
        let app = XCUIApplication()
        app.launch()

        XCTAssertTrue(app.staticTexts["Hello, world!"].waitForExistence(timeout: 10))
        app.staticTexts["Hello, world!"].click()
        app.staticTexts["Hello, world!"].click()
        app.staticTexts["Hello, world!"].click()
    }
}
