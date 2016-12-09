import XCTest
@testable import Aiger

class AigerTests: XCTestCase {
    func testIterator() {
        guard let aiger = Aiger(from: "aag 3 2 0 1 1\n2\n4\n6\n6 2 4\n") else {
            XCTFail()
            return
        }
        XCTAssert(aiger.inputs.underestimatedCount == 2)
        for symbol in aiger.inputs {
            XCTAssert(symbol.lit == 2 || symbol.lit == 4)
        }
        XCTAssert(aiger.outputs.underestimatedCount == 1)
        for symbol in aiger.outputs {
            XCTAssert(symbol.lit == 6)
        }
        XCTAssert(aiger.latches.underestimatedCount == 0)
        XCTAssert(aiger.ands.underestimatedCount == 1)
        for and in aiger.ands {
            XCTAssert(and.lhs == 6)
        }
        
        XCTAssertFalse(aiger.reencoded())
    }


    static var allTests : [(String, (AigerTests) -> () throws -> Void)] {
        return [
            ("testIterator", testIterator),
        ]
    }
}
