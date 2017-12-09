/*
 *  DropBehavior.swift
 *  Swiftgres
 *
 *  Copyright (c) 2018 David Piper, @_davidpiper
 *
 *  This software may be modified and distributed under the terms
 *  of the MIT license. See the LICENSE file for details.
 */

public enum DropBehavior: PostgresGrammarType {
    case cascade
    case restrict
    
    public var description: String {
        switch self {
        case .cascade:
            return "\(KW.CASCADE)"
        case .restrict:
            return "\(KW.RESTRICT)"
        }
    }
    
    public func isValid() -> Bool {
        return true
    }
}
