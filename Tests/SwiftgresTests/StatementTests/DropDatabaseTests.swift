/*
 *  DropDatabaseTests.swift
 *  Swiftgres
 *
 *  Copyright (c) 2018 David Piper, @_davidpiper
 *
 *  This software may be modified and distributed under the terms
 *  of the MIT license. See the LICENSE file for details.
 */

import XCTest
@testable import Swiftgres

class DropDatabaseTests: XCTestCase {
    static var allTests = [
        ("testDrop", testDrop),
        ("testInvalidDrop", testInvalidDrop),
        ("testDropIfExists", testDropIfExists),
        ("testInvalidDropIfExists", testInvalidDropIfExists)
    ]
    
    func testDrop() {
        let statement = PGStatement.dropDatabase("name")
        XCTAssertEqual(try! statement.toSql(), "DROP DATABASE name;")
    }
    
    func testInvalidDrop() {
        let statement = PGStatement.dropDatabase(BadGrammar.databaseName())
        XCTAssertThrowsError(try statement.toSql())
    }
    
    func testDropIfExists() {
        let statement = PGStatement.dropDatabaseIfExists("name")
        XCTAssertEqual(try! statement.toSql(), "DROP DATABASE IF EXISTS name;")
    }
    
    func testInvalidDropIfExists() {
        let statement = PGStatement.dropDatabaseIfExists(BadGrammar.databaseName())
        XCTAssertThrowsError(try statement.toSql())
    }
}
