/*
 *  VarValue.swift
 *  Swiftgres
 *
 *  Copyright (c) 2018 David Piper, @_davidpiper
 *
 *  This software may be modified and distributed under the terms
 *  of the MIT license. See the LICENSE file for details.
 */

// TODO
public struct VarValue: PostgresGrammarType {
    public var description: String {
        return ""
    }
    
    public func isValid() -> Bool {
        return false
    }
}

public struct VarList: PostgresGrammarType, ExpressibleByArrayLiteral {
    private let values: [VarValue]
    
    public init(arrayLiteral elements: VarValue...) {
        self.init(elements)
    }
    
    public init(_ values: [VarValue]) {
        self.values = values
    }
    
    public var description: String {
        return values.map { "\($0)" }.joined(separator: ",")
    }
    
    public func isValid() -> Bool {
        return ValidArrayHelper.isValidAndNotEmpty(values)
    }
}
