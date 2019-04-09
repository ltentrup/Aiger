import CAiger

public class Aiger {
    let _aiger: UnsafeMutablePointer<aiger>
    internal var _resetOnDealloc: Bool
    
    /// fallback: provide access to C aiger struct
    public var aiger: UnsafeMutablePointer<aiger> {
        return _aiger
    }
    
    public init(resetOnDealloc: Bool = true) {
        _aiger = aiger_init()
        _resetOnDealloc = resetOnDealloc
    }
    
    public convenience init?(from: String, resetOnDealloc: Bool = true) {
        self.init(resetOnDealloc: resetOnDealloc)
        aiger_read_from_string(_aiger, from)
    }
    
    public init(from: UnsafeMutablePointer<aiger>, resetOnDealloc: Bool = false) {
        _aiger = from
        _resetOnDealloc = resetOnDealloc
    }
    
    deinit {
        if _resetOnDealloc {
            aiger_reset(_aiger)
        }
    }
    
    public var maxVar: UInt32 {
        return _aiger.pointee.maxvar
    }
    
    public var inputs: CArrayOverlay<aiger_symbol> {
        return CArrayOverlay(address: _aiger.pointee.inputs, length: Int(_aiger.pointee.num_inputs))
    }
    
    public var outputs: CArrayOverlay<aiger_symbol> {
        return CArrayOverlay(address: _aiger.pointee.outputs, length: Int(_aiger.pointee.num_outputs))
    }
    
    public var latches: CArrayOverlay<aiger_symbol> {
        return CArrayOverlay(address: _aiger.pointee.latches, length: Int(_aiger.pointee.num_latches))
    }
    
    public var ands: CArrayOverlay<aiger_and> {
        return CArrayOverlay(address: _aiger.pointee.ands, length: Int(_aiger.pointee.num_ands))
    }
    
    public func tag(forLit lit: UInt32) -> AigerTag {
        precondition(lit % 2 == 0)
        switch aiger_lit2tag(_aiger, lit) {
        case 0:
            // Constant
            return .Constant
        case 1:
            // Input
            return .Input(aiger_is_input(_aiger, lit)!.pointee)
        case 2:
            // Latch
            return .Latch(aiger_is_latch(_aiger, lit)!.pointee)
        case 3:
            // And
            return .And(aiger_is_and(_aiger, lit)!.pointee)
        default:
            assert(false)
            abort()
        }
    }
    
    public func reencoded() -> Bool {
        return aiger_is_reencoded(_aiger) != 0
    }
}

public enum AigerTag {
    case Constant
    case Input(aiger_symbol)
    case Latch(aiger_symbol)
    case And(aiger_and)
}

public struct CArrayOverlay<T>: Sequence, IteratorProtocol {
    var address: UnsafeMutablePointer<T>!  // is only accessed of length > 0
    var length: Int
    
    public var underestimatedCount: Int
    
    init(address: UnsafeMutablePointer<T>!, length: Int) {
        self.address = address
        self.length = length
        self.underestimatedCount = length
    }
    
    public mutating func next() -> T? {
        if length == 0 {
            return nil
        } else {
            defer {
                length -= 1
                address = address.successor()
            }
            return address.pointee
        }
    }
    
    public subscript(index: Int) -> T {
        get {
            precondition(index < length)
            return address.advanced(by: index).pointee
        }
    }
}

