/*
 *  PostgresGrammarType.swift
 *  Swiftgres
 *
 *  Copyright (c) 2018 David Piper, @_davidpiper
 *
 *  This software may be modified and distributed under the terms
 *  of the MIT license. See the LICENSE file for details.
 */

public protocol PostgresGrammarType: CustomStringConvertible {
    /// Stores the current representation, valid or not
    var description: String { get }
    
    /// Validates and returns the SQL string for this item of grammar.
    /// If the SQL string is invalid (e.g. a reserved keyword has been used
    /// where it is not allowed), throws SwiftgresError.invalidGrammar with
    /// the invalid grammar
    func sqlString() throws -> String
    
    /// Validates this item of grammar
    func isValid() -> Bool
}

extension PostgresGrammarType {
    public func sqlString() throws -> String {
        if isValid() {
            return description
        }
        
        // TODO: Add logging here
        throw SwiftgresError.invalidGrammar(statement: description)
    }
}
