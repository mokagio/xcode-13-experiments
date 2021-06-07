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
}
