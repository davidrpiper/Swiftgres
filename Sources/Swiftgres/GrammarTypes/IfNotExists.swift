/*
 *  IfNotExists.swift
 *  Swiftgres
 *
 *  Copyright (c) 2018 David Piper, @_davidpiper
 *
 *  This software may be modified and distributed under the terms
 *  of the MIT license. See the LICENSE file for details.
 */

public struct IfNotExists: PostgresGrammarType {
    public var description: String {
        return "\(KW.IF) \(KW.NOT) \(KW.EXISTS)"
    }
    
    public func isValid() -> Bool {
        return true
    }
}
