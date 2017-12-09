/*
 *  Identifier.swift
 *  Swiftgres
 *
 *  Copyright (c) 2018 David Piper, @_davidpiper
 *
 *  This software may be modified and distributed under the terms
 *  of the MIT license. See the LICENSE file for details.
 */

import Foundation

public struct Identifier: PostgresGrammarType, ExpressibleByStringLiteral {
    private let value: String
    
    public typealias StringLiteralType = String
    
    public init(stringLiteral value: String) {
        self.init(value)
    }
    
    public init(_ value: String) {
        self.value = value
    }

    public var description: String {
        return value
    }
    
    public func isValid() -> Bool {
        return isNotEmpty() && doesNotContainSemicolon() && containsNoWhitespace() && startsWithValidCharacter() && containsValidCharacters()
    }
    
    private func doesNotContainSemicolon() -> Bool {
        return !value.contains(";")
    }
    
    private func containsNoWhitespace() -> Bool {
        return value.rangeOfCharacter(from: CharacterSet.whitespacesAndNewlines) == nil
    }
    
    private func isNotEmpty() -> Bool {
        return value.utf8.count > 0
    }
    
    private func startsWithValidCharacter() -> Bool {
        return (
            value[value.startIndex] == "_" ||
            CharacterSet.lowercaseLetters.contains(value[value.startIndex].unicodeScalars.first!)
        )
    }
    
    // We're going to be opinionated here and allow only lowercase identifiers.
    // It will save consumers worlds of double-quote pain in the long run.
    private func containsValidCharacters() -> Bool {
        let isInvalid: Bool = value.contains { (char: Character) -> Bool in
            return (
                char != "_" &&
                char != "$" &&
                !CharacterSet.lowercaseLetters.contains(char.unicodeScalars.first!) &&
                !CharacterSet.decimalDigits.contains(char.unicodeScalars.first!)
            );
        }
        
        return !isInvalid;
    }
}
