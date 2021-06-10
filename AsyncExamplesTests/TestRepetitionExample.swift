// Here's a failing test. Run it using the TestRepetitionExample test plan to see different modes of
// test repetition in action. You can do that using the TestRepetitionExamples scheme.
//
// For faster experimentation cycle, got to the test plan file and disable configurations by right
// clicking on them and selecting "Disable".
import XCTest

class TestRepetitionExample: XCTestCase {

    func testThatFailsRandomly() {
        if Int.random(in: 1..<10) % 2 == 0 {
            XCTFail(":trollface:")
        } else {
            XCTAssert(true)
        }
    }
}
