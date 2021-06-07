@testable import AsyncExamples
import XCTest

class AsyncExamplesTests: XCTestCase {

    func testAsyncSuccess() async {
        do {
            let users = try await fetchUsers(count: 3)
            XCTAssertEqual(users.count, 3)
            XCTAssertTrue(users.contains("Ada"))
            XCTAssertTrue(users.contains("Grace"))
            XCTAssertTrue(users.contains("Margaret"))
        } catch {
            XCTFail("Failed with \(error)")
        }
    }

    func testAsyncFailure() async {
        do {
            _ = try await fetchUsers(count: 4)
            XCTFail("Expected async call to fail")
        } catch {
            XCTAssertEqual(error as? UserError, UserError.invalidCount)
        }
    }

    func testAsyncFailure_Alt() async {
        // XCTAssertThrowsError(try await fetchUsers(count: 4))
        // Doesn't compile:
        // > 'async' call in an autoclosure that does not support concurrency
    }

    func testExpectFailure() async throws {
        XCTExpectFailure("This test is expected to fail")

        do {
            let users = try await fetchUsers(count: 4)
            // assertions here...
        } catch {
            XCTFail("Failed with \(error)")
        }
    }

    func testExpectFailureWithMatcher() {
        // Does not support async functions in the closure
        XCTExpectFailure("This test is expected to fail") {
            XCTAssertEqual(42, 24)
        } issueMatcher: { issue in
            return issue.compactDescription == #"XCTAssertEqual failed: ("42") is not equal to ("24")"#
        }
    }
}
