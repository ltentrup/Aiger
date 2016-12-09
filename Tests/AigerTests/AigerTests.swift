import XCTest
@testable import Aiger

class AigerTests: XCTestCase {
    func testIterator() {
        guard let aiger = Aiger(from: "aag 3 2 0 1 1\n2\n4\n6\n6 2 4\n") else {
            XCTFail()
            return
        }
        XCTAssertEqual(aiger.inputs.underestimatedCount, 2)
        for symbol in aiger.inputs {
            XCTAssert(symbol.lit == 2 || symbol.lit == 4)
        }
        
        XCTAssertEqual(aiger.outputs.underestimatedCount, 1)
        for symbol in aiger.outputs {
            XCTAssertEqual(symbol.lit, 6)
        }
        XCTAssertEqual(aiger.outputs[0].lit, 6)
        
        
        XCTAssertEqual(aiger.latches.underestimatedCount, 0)
        
        XCTAssertEqual(aiger.ands.underestimatedCount, 1)
        for and in aiger.ands {
            XCTAssertEqual(and.lhs, 6)
            XCTAssertEqual(and.rhs0, 2)
            XCTAssertEqual(and.rhs1, 4)
        }
        
        XCTAssertFalse(aiger.reencoded())
    }


    static var allTests : [(String, (AigerTests) -> () throws -> Void)] {
        return [
            ("testIterator", testIterator),
        ]
    }
}
