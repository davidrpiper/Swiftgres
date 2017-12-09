/*
 *  DiscardTests.swift
 *  Swiftgres
 *
 *  Copyright (c) 2018 David Piper, @_davidpiper
 *
 *  This software may be modified and distributed under the terms
 *  of the MIT license. See the LICENSE file for details.
 */

import XCTest
@testable import Swiftgres

class DiscardTests: XCTestCase {
    static var allTests = [
        ("testDiscardAll", testDiscardAll),
        ("testDiscardTemp", testDiscardTemp),
        ("testDiscardTemporary", testDiscardTemporary),
        ("testDiscardPlans", testDiscardPlans),
        ("testDiscardSequences", testDiscardSequences)
    ]
    
    func testDiscardAll() {
        let statement = PGStatement.discardAll()
        XCTAssertEqual(try! statement.toSql(), "DISCARD ALL;")
    }
    
    func testDiscardTemp() {
        let statement = PGStatement.discardTemp()
        XCTAssertEqual(try! statement.toSql(), "DISCARD TEMP;")
    }
    
    func testDiscardTemporary() {
        let statement = PGStatement.discardTemporary()
        XCTAssertEqual(try! statement.toSql(), "DISCARD TEMPORARY;")
    }
    
    func testDiscardPlans() {
        let statement = PGStatement.discardPlans()
        XCTAssertEqual(try! statement.toSql(), "DISCARD PLANS;")
    }
    
    func testDiscardSequences() {
        let statement = PGStatement.discardSequences()
        XCTAssertEqual(try! statement.toSql(), "DISCARD SEQUENCES;")
    }
}

