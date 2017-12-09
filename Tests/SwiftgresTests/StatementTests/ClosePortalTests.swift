/*
 *  ClosePortalTests.swift
 *  Swiftgres
 *
 *  Copyright (c) 2018 David Piper, @_davidpiper
 *
 *  This software may be modified and distributed under the terms
 *  of the MIT license. See the LICENSE file for details.
 */

import XCTest
@testable import Swiftgres

class ClosePortalTests: XCTestCase {
    static var allTests = [
        ("testCloseCursor", testCloseCursor),
        ("testCloseInvalidCursor", testCloseInvalidCursor),
        ("testCloseAll", testCloseAll)
    ]
    
    func testCloseCursor() {
        let statement = PGStatement.close("name")
        XCTAssertEqual(try! statement.toSql(), "CLOSE name;")
    }
    
    func testCloseInvalidCursor() {
        let statement = PGStatement.close(BadGrammar.cursorName())
        XCTAssertThrowsError(try statement.toSql())
    }
    
    func testCloseAll() {
        let statement = PGStatement.closeAll()
        XCTAssertEqual(try! statement.toSql(), "CLOSE ALL;")
    }
}
