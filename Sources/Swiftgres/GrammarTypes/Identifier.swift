//
//  Identifier.swift
//  SwiftgresPackageDescription
//
//  Created by David Piper on 26/11/17.
//

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
        return isNotEmpty() && containsNoWhitespace() && startsWithValidCharacter() && containsValidCharacters()
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
