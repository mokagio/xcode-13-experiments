import XCTest

class AsyncAwaitTestExamples: XCTestCase {

    // Before, with callbacks

    func testChopVegetables_callback() {
        let expectation = XCTestExpectation(description: "Chops the vegetables")

        chopVegetables { result in
            guard case .success(let vegetables) = result else { return }

            XCTAssertEqual(vegetables.count, 3)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1)
    }

    // After, with async/await

    func testChopVegetables() async throws {
        let vegetables = try await chopVegetables()
        XCTAssertGreaterThan(vegetables.count, 1)
    }

    func testChopVegetablesWithErrorHandling() async throws {
        do {
            let vegetables = try await chopVegetables()
            XCTAssertEqual(vegetables.count, 3)
        } catch {
            XCTFail("Expected chopped vegetables, but failed \(error).")
        }
    }

    // This will fail because the async call throws.
    //
    // > caught error: "The operation couldn’t be completed. (AsyncExamplesTests.CookingError error 0.)"
    /*
    func testChopVegetablesThrowsErrorWhenKnifeBlunt() async throws {
        let vegetables = try await chopVegetables(using: Knife(sharpness: .low))
        XCTAssertEqual(vegetables.count, 3)
    }
     */

    // This doesn't work because XCTAssertThrow doesn't support concurrency.
    //
    // > 'async' call in an autoclosure that does not support concurrency
    /*
    func testChopVegetablesThrowsErrorWhenKnifeBlunt() async throws {
        XCTAssertThrowsError(try await chopVegetables(using: Knife(sharpness: .low)))
    }
     */

    func testChopVegetablesThrowsErrorWhenKnifeBlunt() async {
        do {
            let vegetables = try await chopVegetables(using: Knife(sharpness: .low))
            XCTFail("Expected to throw while awaiting, succeeded with \(vegetables)")
        } catch {
            XCTAssertEqual(error as? CookingError, .knifeTooBlunt)
        }
    }
}

// MARK: -

func chopVegetables(completion: @escaping (Result<[Vegetable], CookingError>) -> Void) {
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
        completion(.success([Vegetable(), Vegetable(), Vegetable()]))
    }
}

func chopVegetables(using knife: Knife = Knife()) async throws -> [Vegetable] {
    switch knife.sharpness {
    case .low: throw CookingError.knifeTooBlunt
    case _: return [Vegetable(), Vegetable(), Vegetable()]
    }
}

struct Vegetable {}

enum CookingError: Error {
    case knifeTooBlunt
    case benchTooDirty
}

struct Knife {
    enum Sharepness {
        case high
        case normal
        case low
    }

    private(set) var sharpness: Sharepness = .high
}
