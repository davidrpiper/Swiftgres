/*
 *  NotifyTests.swift
 *  Swiftgres
 *
 *  Copyright (c) 2018 David Piper, @_davidpiper
 *
 *  This software may be modified and distributed under the terms
 *  of the MIT license. See the LICENSE file for details.
 */

import XCTest
@testable import Swiftgres

class NotifyTests: XCTestCase {
    static var allTests = [
        ("testNotify", testNotify),
        ("testNotifyWithPayload", testNotifyWithPayload),
        ("testInvalidNotify", testInvalidNotify),
        ("testInvalidNotifyWithPayload", testInvalidNotifyWithPayload)
    ]
    
    func testNotify() {
        let statement = PGStatement.notify("channel")
        XCTAssertEqual(try! statement.toSql(), "NOTIFY channel;")
    }
    
    func testNotifyWithPayload() {
        let statement = PGStatement.notify("channel", "payload")
        XCTAssertEqual(try! statement.toSql(), "NOTIFY channel, 'payload';")
    }
    
    func testInvalidNotify() {
        let statement = PGStatement.notify(BadGrammar.colId())
        XCTAssertThrowsError(try statement.toSql())
    }
    
    func testInvalidNotifyWithPayload() {
        let statement = PGStatement.notify(BadGrammar.colId(), "payload")
        XCTAssertThrowsError(try statement.toSql())
    }
}
