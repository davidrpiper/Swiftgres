/*
 *  Name.swift
 *  Swiftgres
 *
 *  Copyright (c) 2018 David Piper, @_davidpiper
 *
 *  This software may be modified and distributed under the terms
 *  of the MIT license. See the LICENSE file for details.
 */

public typealias Name = ColId
public typealias CursorName = Name

public struct NameList: PostgresGrammarType, ExpressibleByArrayLiteral {
    private let names: [Name]
    
    public init(arrayLiteral elements: Name...) {
        self.init(elements)
    }
    
    public init(_ names: [Name]) {
        self.names = names
    }
    
    public var description: String {
        return names.map { "\($0)" }.joined(separator: ",")
    }
    
    public func isValid() -> Bool {
        return ValidArrayHelper.isValidAndNotEmpty(names)
    }
}
