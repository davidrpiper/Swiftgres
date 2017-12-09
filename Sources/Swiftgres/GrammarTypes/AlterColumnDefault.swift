/*
 *  AlterColumnDefault.swift
 *  Swiftgres
 *
 *  Copyright (c) 2018 David Piper, @_davidpiper
 *
 *  This software may be modified and distributed under the terms
 *  of the MIT license. See the LICENSE file for details.
 */

public enum AlterColumnDefault: PostgresGrammarType {
    case setDefault(Aexpr)
    case dropDefault
    
    public var description: String {
        switch self {
        case .setDefault(let aexpr):
            return "\(KW.SET) \(KW.DEFAULT) \(aexpr)"
        case .dropDefault:
            return "\(KW.DROP) \(KW.DEFAULT)"
        }
    }
    
    public func isValid() -> Bool {
        // TODO: Check aexpr if aexpr changes
        return true
    }
}
