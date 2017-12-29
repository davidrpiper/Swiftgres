/*
 *  IsolationLevel.swift
 *  Swiftgres
 *
 *  Copyright (c) 2018 David Piper, @_davidpiper
 *
 *  This software may be modified and distributed under the terms
 *  of the MIT license. See the LICENSE file for details.
 */

// iso_level
public enum IsolationLevel: PostgresGrammarType {
    case readUncommitted
    case readCommitted
    case repeatableRead
    case serializable
    
    public var description: String {
        switch self {
        case .readUncommitted:
            return "\(KW.READ) \(KW.UNCOMMITTED)"
        case .readCommitted:
            return "\(KW.READ) \(KW.COMMITTED)"
        case .repeatableRead:
            return "\(KW.REPEATABLE) \(KW.READ)"
        case .serializable:
            return "\(KW.SERIALIZABLE)"
        }
    }
    
    public func isValid() -> Bool {
        return true
    }
}
