import XCTest

class ExpectFailureExamples: XCTestCase {

    let demoingFailures = false

    func testExpectFailure() {
        XCTExpectFailure("Failure expected till we fix #123")
        XCTAssertEqual(computeAnswer(), 42)
    }

    // "strict" makes the test fail if there's no failure. It's `true` by default.
    // Use `strict: false` to allow tests to pass.
    func testExpectFailureNotStrict() throws {
        XCTExpectFailure("This test is flaky. Will fix as part of #234", strict: false)
        XCTAssertEqual(computeAnswer(), 42)
    }

    // You can use a closure to drill into the failure (`XCIssue`) that the test experienced to
    // ensure it's the one you expect.
    func testExpectFailureDrillDown() {
        XCTExpectFailure("Failure expected till we fix #123") { issue in
            issue.compactDescription.contains(#"("73") is not equal to ("42")"#)
        }
        XCTAssertEqual(computeAnswer(), 42)
    }

    // `XCTExpectFailure` can also handle code that throws. Here's an example of code that would
    // throw and fail the test.
    func testBrokenByCodeThatThrows() throws {
        try XCTSkipUnless(demoingFailures, "Skipping because this test demoes a failure")

        let number = try codeThatThrows()
        let otherNumber = 21
        XCTAssertEqual(number + otherNumber, 42)
    }

    // Using `XCTExpectFailure(_, failingBlock:)` you can handle expected failures in code that
    // throws.
    func testExpectFailureWithAssert() throws {
        let number = try XCTExpectFailure("Failure expected till we fix #123") {
            try codeThatThrows()
        }
        let otherNumber = 21
        XCTAssertEqual(number + otherNumber, 42)
    }

    // `XCTExpectFailure(_, failingBlock:)` `rethrows` so it doesn't affect the control flow of
    // the code under test. That means that you if the code doesn't end up throwing, you can use
    // the result
    func testExpectFailureWithAssert_showingUnalteredControlFlow() throws {
        let number = try XCTExpectFailure("Failure expected till we fix #123", options: .nonStrict()) {
            try codeThatThrowsButNotReally()
        }
        let otherNumber = 21
        XCTAssertEqual(number + otherNumber, 42)
    }

}

struct TestError: Error {}

func computeAnswer() -> Int {
    73
    // Wrong result! Should be 42.
    // See https://en.wikipedia.org/wiki/42_(number)#The_Hitchhiker's_Guide_to_the_Galaxy
}

func codeThatThrows() throws -> Int { throw TestError() }

func codeThatThrowsButNotReally() throws -> Int { 21 }
