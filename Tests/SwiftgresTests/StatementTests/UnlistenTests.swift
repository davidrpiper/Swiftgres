/*
 *  UnlistenTests.swift
 *  Swiftgres
 *
 *  Copyright (c) 2018 David Piper, @_davidpiper
 *
 *  This software may be modified and distributed under the terms
 *  of the MIT license. See the LICENSE file for details.
 */

import XCTest
@testable import Swiftgres

class UnlistenTests: XCTestCase {
    static var allTests = [
        ("testUnlistenCol", testUnlistenCol),
        ("testInvalidUnlistenCol", testInvalidUnlistenCol),
        ("testUnlistenAll", testUnlistenAll)
    ]
    
    func testUnlistenCol() {
        let statement = PGStatement.unlisten("channel")
        XCTAssertEqual(try! statement.toSql(), "UNLISTEN channel;")
    }
    
    func testInvalidUnlistenCol() {
        let statement = PGStatement.unlisten(BadGrammar.colId())
        XCTAssertThrowsError(try statement.toSql())
    }
    
    func testUnlistenAll() {
        let statement = PGStatement.unlistenAll()
        XCTAssertEqual(try! statement.toSql(), "UNLISTEN '*';")
    }
}
