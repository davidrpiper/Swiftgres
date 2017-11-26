/*
 *  IdentifierTests.swift
 *  Swiftgres
 *
 *  Copyright (c) 2018 David Piper, @_davidpiper
 *
 *  This software may be modified and distributed under the terms
 *  of the MIT license. See the LICENSE file for details.
 */

import XCTest
@testable import Swiftgres

class IdentifierTests: XCTestCase {
    static var allTests = [
        ("testLowercaseIsValid", testLowercaseIsValid),
        ("testAnyUppercaseIsInvalid", testAnyUppercaseIsInvalid),
        ("testLowercaseAndUnderscoresAreValid", testLowercaseAndUnderscoresAreValid),
        ("testDollarSignsAreValid", testDollarSignsAreValid),
        ("testDigitsAreValidIfNotAtStart", testDigitsAreValidIfNotAtStart),
        ("testIdentifierCannotStartWithDigitOrDollar", testIdentifierCannotStartWithDigitOrDollar),
        ("testIdentifierCannotHaveWhitespace", testIdentifierCannotHaveWhitespace),
        ("testEmptyIdentifierIsInvalid", testEmptyIdentifierIsInvalid)
    ]
    
    func testLowercaseIsValid() {
        let id: Identifier = "abc"
        XCTAssertTrue(id.isValid())
        
        let id2: Identifier = "a"
        XCTAssertTrue(id2.isValid())
        
        let id3: Identifier = "abcdefghijklmnopqrstuvwxyz"
        XCTAssertTrue(id3.isValid())
    }
    
    func testAnyUppercaseIsInvalid() {
        let id1: Identifier = "ABC"
        XCTAssertFalse(id1.isValid())
        
        let id2: Identifier = "Z"
        XCTAssertFalse(id2.isValid())
        
        let id3: Identifier = "abC"
        XCTAssertFalse(id3.isValid())
    }
    
    func testLowercaseAndUnderscoresAreValid() {
        let id1: Identifier = "o_o"
        XCTAssertTrue(id1.isValid())
        
        let id2: Identifier = "o_o_"
        XCTAssertTrue(id2.isValid())
        
        let id3: Identifier = "_o_o_"
        XCTAssertTrue(id3.isValid())
    }
    
    func testDollarSignsAreValid() {
        let id1: Identifier = "o$o"
        XCTAssertTrue(id1.isValid())
        
        let id2: Identifier = "o$o$"
        XCTAssertTrue(id2.isValid())
    }
    
    func testDigitsAreValidIfNotAtStart() {
        let id1: Identifier = "a1234567890"
        XCTAssertTrue(id1.isValid())
        
        let id2: Identifier = "a1b2c3d4e5f6g7h8i9j0"
        XCTAssertTrue(id2.isValid())
    }
    
    func testIdentifierCannotStartWithDigitOrDollar() {
        let id1: Identifier = "1a"
        XCTAssertFalse(id1.isValid())
        
        let id2: Identifier = "$a"
        XCTAssertFalse(id2.isValid())
    }
    
    func testIdentifierCannotHaveWhitespace() {
        let id1: Identifier = "a b"
        XCTAssertFalse(id1.isValid())
        
        let id2: Identifier = " ab"
        XCTAssertFalse(id2.isValid())
        
        let id3: Identifier = "ab "
        XCTAssertFalse(id3.isValid())
        
        let id4: Identifier = " ab "
        XCTAssertFalse(id4.isValid())
        
        let id5: Identifier = " a b "
        XCTAssertFalse(id5.isValid())
    }
    
    func testEmptyIdentifierIsInvalid() {
        let id: Identifier = ""
        XCTAssertFalse(id.isValid())
    }
}
