import CAiger

public struct Aiger {
    let _aiger: UnsafeMutablePointer<aiger>
    
    public init() {
        _aiger = aiger_init()
    }
    
    public init(from: String) {
        self.init()
        aiger_read_from_string(_aiger, from)
    }
    
    public init(from: UnsafeMutablePointer<aiger>) {
        _aiger = from
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
}

