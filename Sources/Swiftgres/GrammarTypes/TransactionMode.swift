/*
 *  TransactionMode.swift
 *  Swiftgres
 *
 *  Copyright (c) 2018 David Piper, @_davidpiper
 *
 *  This software may be modified and distributed under the terms
 *  of the MIT license. See the LICENSE file for details.
 */

public enum TransactionModeItem: PostgresGrammarType {
    case isolationLevel(IsolationLevel)
    case readOnly
    case readWrite
    case deferrable
    case notDeferrable
    
    public var description: String {
        switch self {
        case .isolationLevel(let isoLevel):
            return "\(KW.ISOLATION) \(KW.LEVEL) \(isoLevel)"
        case .readOnly:
            return "\(KW.READ) \(KW.ONLY)"
        case .readWrite:
            return "\(KW.READ) \(KW.WRITE)"
        case .deferrable:
            return "\(KW.DEFERRABLE)"
        case .notDeferrable:
            return "\(KW.NOT) \(KW.DEFERRABLE)"
        }
    }
    
    public func isValid() -> Bool {
        if case .isolationLevel(let isoLevel) = self {
            return isoLevel.isValid()
        }
        
        return true
    }
}

public struct TransactionModeList: PostgresGrammarType, ExpressibleByArrayLiteral {
    private let modes: [TransactionModeItem]
    
    public init(arrayLiteral elements: TransactionModeItem...) {
        self.init(elements)
    }
    
    public init(_ modes: [TransactionModeItem]) {
        self.modes = modes
    }
    
    public var description: String {
        return modes.map { "\($0)" }.joined(separator: ",")
    }
    
    public func isValid() -> Bool {
        return ValidArrayHelper.isValidAndNotEmpty(modes)
    }
}
