/*
 *  ValidArrayHelperTests.swift
 *  Swiftgres
 *
 *  Copyright (c) 2018 David Piper, @_davidpiper
 *
 *  This software may be modified and distributed under the terms
 *  of the MIT license. See the LICENSE file for details.
 */

import XCTest
@testable import Swiftgres

struct LowercaseString: PostgresGrammarType, ExpressibleByStringLiteral {
    private let str: String
    
    init(stringLiteral value: String) {
        self.init(value)
    }
    
    init(_ value: String) {
        str = value
    }
    
    var description: String {
        return "\(str)"
    }
    
    func isValid() -> Bool {
        return str.lowercased() == str
    }
}

class ValidArrayHelperTests: XCTestCase {
    static var allTests = [
        ("testIsValid", testIsValid),
        ("testIsValidAndNotEmpty", testIsValidAndNotEmpty)
    ]
    
    func testIsValid() {
        let arrayLowercase: [LowercaseString] = ["abc", "def", "ghi"]
        XCTAssertTrue(ValidArrayHelper.isValid(arrayLowercase))
        
        let arrayUppercase: [LowercaseString] = ["ABC", "DEF", "GHI"]
        XCTAssertFalse(ValidArrayHelper.isValid(arrayUppercase))
        
        let arrayWithUppercase: [LowercaseString] = ["abc", "dEf", "ghi"]
        XCTAssertFalse(ValidArrayHelper.isValid(arrayWithUppercase))
        
        let emptyArray: [LowercaseString] = []
        XCTAssertTrue(ValidArrayHelper.isValid(emptyArray))
    }
    
    func testIsValidAndNotEmpty() {
        let arrayLowercase: [LowercaseString] = ["abc", "def", "ghi"]
        XCTAssertTrue(ValidArrayHelper.isValidAndNotEmpty(arrayLowercase))
        
        let arrayUppercase: [LowercaseString] = ["ABC", "DEF", "GHI"]
        XCTAssertFalse(ValidArrayHelper.isValidAndNotEmpty(arrayUppercase))
        
        let arrayWithUppercase: [LowercaseString] = ["abc", "dEf", "ghi"]
        XCTAssertFalse(ValidArrayHelper.isValidAndNotEmpty(arrayWithUppercase))
        
        let emptyArray: [LowercaseString] = []
        XCTAssertFalse(ValidArrayHelper.isValidAndNotEmpty(emptyArray))
    }
}
