import XCTest

class ExpectFailureExamples: XCTestCase {

    let demoingFailures = false

    func testExpectFailure() {
        XCTExpectFailure("Some reason why the failure is expected")
        XCTAssertEqual(42, 24)
    }

    // You can use "strict" to fail the test if there's no failure.
    func testExpectFailureStrict() throws {
        try XCTSkipUnless(demoingFailures, "Skipping this test because it would fail since we're using strict mode")
        XCTExpectFailure("Some reason why the failure is expected", strict: true)
        // Equivalent to
        let options = XCTExpectedFailure.Options()
        options.isEnabled = true
        options.isStrict = true
        XCTExpectFailure("Some reason why the failure is expected", options: options)
    }

    // You can use a closure to drill into the failure (`XCIssue`) that the test experienced to
    // ensure it's the one you expect
    func testExpectFailureDrillDown() {
        XCTExpectFailure("Math is broken right now") { issue in
            issue.compactDescription.contains(#"("42") is not equal to ("24")"#)
        }
        XCTAssertEqual(42, 24)
    }

    // You can use it to handle code that throws, too

    func testBrokenByCodeThatThrows() throws {
        try XCTSkipUnless(demoingFailures, "Skipping because this test demoes a failure")

        let number = try codeThatThrows()
        let otherNumber = 21
        XCTAssertEqual(number + otherNumber, 42)
    }

    func testExpectFailureWithAssert() throws {
        let number = try XCTExpectFailure("How does this work?") {
            try codeThatThrows()
        }
        let otherNumber = 21
        XCTAssertEqual(number + otherNumber, 42)
    }

    func testExpectFailureWithAssert_showingUnalteredControlFlow() throws {
        let number = try XCTExpectFailure("How does this work?", options: .nonStrict()) {
            try codeThatThrowsButNotReally()
        }
        let otherNumber = 21
        XCTAssertEqual(number + otherNumber, 42)
    }
}

struct TestError: Error {}

func codeThatThrows() throws -> Int { throw TestError() }

func codeThatThrowsButNotReally() throws -> Int { 21 }
