/*
 *  AlterCollationTests.swift
 *  Swiftgres
 *
 *  Copyright (c) 2018 David Piper, @_davidpiper
 *
 *  This software may be modified and distributed under the terms
 *  of the MIT license. See the LICENSE file for details.
 */

import XCTest
@testable import Swiftgres

class AlterCollationTests: XCTestCase {
    static var allTests = [
        ("testValidStatement", testValidStatement),
        ("testInvalidGrammar", testInvalidGrammar)
    ]
    
    func testValidStatement() {
        let statement = PGStatement.alterCollation("collation").refreshVersion();
        XCTAssertEqual(try! statement.toSql(), "ALTER COLLATION collation REFRESH VERSION;")
    }
    
    func testInvalidGrammar() {
        let statement = PGStatement.alterCollation(BadGrammar.anyName()).refreshVersion();
        XCTAssertThrowsError(try statement.toSql())
    }
}
