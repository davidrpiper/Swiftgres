/*
 *  EnableTrigger.swift
 *  Swiftgres
 *
 *  Copyright (c) 2018 David Piper, @_davidpiper
 *
 *  This software may be modified and distributed under the terms
 *  of the MIT license. See the LICENSE file for details.
 */

public enum EnableTrigger: PostgresGrammarType {
    case enable
    case enableReplica
    case enableAlways
    case disable
    
    public var description: String {
        switch self {
        case .enable:
            return "\(KW.ENABLE)"
        case .enableReplica:
            return "\(KW.ENABLE) \(KW.REPLICA)"
        case .enableAlways:
            return "\(KW.ENABLE) \(KW.ALWAYS)"
        case .disable:
            return "\(KW.DISABLE)"
        }
    }
    
    public func isValid() -> Bool {
        return true
    }
}
