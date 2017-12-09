/*
 *  AlterEventTriggerTests.swift
 *  Swiftgres
 *
 *  Copyright (c) 2018 David Piper, @_davidpiper
 *
 *  This software may be modified and distributed under the terms
 *  of the MIT license. See the LICENSE file for details.
 */

import XCTest
@testable import Swiftgres

class AlterEventTriggerTests: XCTestCase {
    static var allTests = [
        ("testEnable", testEnable),
        ("testEnableAlways", testEnableAlways),
        ("testEnableReplica", testEnableReplica),
        ("testDisable", testDisable),
        ("testInvalidGrammar", testInvalidGrammar)
    ]
    
    func testEnable() {
        let statement = PGStatement.alterEventTrigger("name", .enable)
        XCTAssertEqual(try! statement.toSql(), "ALTER EVENT TRIGGER name ENABLE;")
    }
    
    func testEnableAlways() {
        let statement = PGStatement.alterEventTrigger("name", .enableAlways)
        XCTAssertEqual(try! statement.toSql(), "ALTER EVENT TRIGGER name ENABLE ALWAYS;")
    }
    
    func testEnableReplica() {
        let statement = PGStatement.alterEventTrigger("name", .enableReplica)
        XCTAssertEqual(try! statement.toSql(), "ALTER EVENT TRIGGER name ENABLE REPLICA;")
    }
    
    func testDisable() {
        let statement = PGStatement.alterEventTrigger("name", .disable)
        XCTAssertEqual(try! statement.toSql(), "ALTER EVENT TRIGGER name DISABLE;")
    }
    
    func testInvalidGrammar() {
        let statement = PGStatement.alterEventTrigger(BadGrammar.name(), .enable)
        XCTAssertThrowsError(try statement.toSql())
    }
}

