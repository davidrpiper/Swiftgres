/*
 *  VariableShowTests.swift
 *  Swiftgres
 *
 *  Copyright (c) 2018 David Piper, @_davidpiper
 *
 *  This software may be modified and distributed under the terms
 *  of the MIT license. See the LICENSE file for details.
 */

import XCTest
@testable import Swiftgres

class VariableShowTests: XCTestCase {
    static var allTests = [
        ("testTimezone", testTimezone),
        ("testTransactionIsolationLevel", testTransactionIsolationLevel),
        ("testSession", testSession),
        ("testAuthorization", testAuthorization),
        ("testAll", testAll),
        ("testVariable", testVariable),
        ("testInvalidVariable", testInvalidVariable)
    ]
    
    func testTimezone() {
        let statement = PGStatement.show(.timezone)
        XCTAssertEqual(try! statement.toSql(), "SHOW TIME ZONE;")
    }
    
    func testTransactionIsolationLevel() {
        let statement = PGStatement.show(.transactionIsolationLevel)
        XCTAssertEqual(try! statement.toSql(), "SHOW TRANSACTION ISOLATION LEVEL;")
    }
    
    func testSession() {
        let statement = PGStatement.show(.session)
        XCTAssertEqual(try! statement.toSql(), "SHOW SESSION;")
    }
    
    func testAuthorization() {
        let statement = PGStatement.show(.authorization)
        XCTAssertEqual(try! statement.toSql(), "SHOW AUTHORIZATION;")
    }
    
    func testAll() {
        let statement = PGStatement.show(.all)
        XCTAssertEqual(try! statement.toSql(), "SHOW ALL;")
    }
    
    func testVariable() {
        let statement = PGStatement.show("name")
        XCTAssertEqual(try! statement.toSql(), "SHOW name;")
    }
    
    func testInvalidVariable() {
        let statement = PGStatement.show(BadGrammar.varName())
        XCTAssertThrowsError(try statement.toSql())
    }
    
}


