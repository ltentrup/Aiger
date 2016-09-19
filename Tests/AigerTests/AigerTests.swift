import XCTest
@testable import Aiger

class AigerTests: XCTestCase {
    func testIterator() {
        let aiger = Aiger(from: "aag 3 2 0 1 1\n2\n4\n6\n6 2 4\n")
        for symbol in aiger.inputs {
            assert(symbol.lit == 2 || symbol.lit == 4)
        }
        for symbol in aiger.outputs {
            assert(symbol.lit == 6)
        }
        assert(aiger.latches.underestimatedCount == 0)
        for and in aiger.ands {
            assert(and.lhs == 6)
        }
    }


    static var allTests : [(String, (AigerTests) -> () throws -> Void)] {
        return [
            ("testIterator", testIterator),
        ]
    }
}
