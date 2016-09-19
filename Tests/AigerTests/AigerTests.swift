import XCTest
@testable import Aiger

class AigerTests: XCTestCase {
    func testIterator() {
        let aiger = Aiger(from: "aag 3 2 0 1 1\n2\n4\n6\n6 2 4\n")
        assert(aiger.inputs.underestimatedCount == 2)
        for symbol in aiger.inputs {
            assert(symbol.lit == 2 || symbol.lit == 4)
        }
        assert(aiger.outputs.underestimatedCount == 1)
        for symbol in aiger.outputs {
            assert(symbol.lit == 6)
        }
        assert(aiger.latches.underestimatedCount == 0)
        assert(aiger.ands.underestimatedCount == 1)
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
