/*
 *  ColId.swift
 *  Swiftgres
 *
 *  Copyright (c) 2018 David Piper, @_davidpiper
 *
 *  This software may be modified and distributed under the terms
 *  of the MIT license. See the LICENSE file for details.
 */

/**
    A ColId is one of the most basic form of identifiers in the Postgres Grammar.
    While ostensibly the name of a column, it is used in all parts of the grammar
    for different purposes.
 
    A ColId with attributes looks like "col.attrone.attrtwo"
 
    The only practical restriction on ColId is that it (and its attributes)
    cannot be a reserved keyword.
 */
public struct ColIdWithAttrs: PostgresGrammarType, ExpressibleByStringLiteral {
    private let idWithAttrs: String
    
    public init(stringLiteral value: String) {
        self.init(value)
    }
    
    public init(_ value: String) {
        idWithAttrs = value
    }
    
    public var description: String {
        return idWithAttrs
    }
    
    public func isValid() -> Bool {
        let tokens = idWithAttrs.split(separator: ".")
        let identifiers = tokens.map { Identifier(String($0)) }
        return ValidArrayHelper.isValidAndNotEmpty(identifiers) && tokens.first { ReservedHelper.isReserved(keyword: String($0)) } == nil
    }
}

/**
    A single ColId cannot contain attrs.
 */
public struct ColId: PostgresGrammarType, ExpressibleByStringLiteral {
    private let id: Identifier
    
    public init(stringLiteral value: String) {
        self.init(value)
    }
    
    public init(_ value: String) {
        id = Identifier(value)
    }
    
    public var description: String {
        return "\(id)"
    }
    
    public func isValid() -> Bool {
        return id.isValid() && !ReservedHelper.isReserved(keyword: "\(id)")
    }
}

/**
    Standalone and non-listable Aliases for ColId in the grammar.
 */
public typealias DatabaseName = ColId
public typealias AccessMethod = ColId
public typealias IndexName = ColId
public typealias ColumnElem = ColId
public typealias TransitionRelName = ColId

public typealias OptSchemaName = ColId?
public typealias VarName = ColIdWithAttrs
public typealias AnyName = ColIdWithAttrs
