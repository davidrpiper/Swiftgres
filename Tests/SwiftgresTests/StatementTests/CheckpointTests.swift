/*
 *  CheckpointTests.swift
 *  Swiftgres
 *
 *  Copyright (c) 2018 David Piper, @_davidpiper
 *
 *  This software may be modified and distributed under the terms
 *  of the MIT license. See the LICENSE file for details.
 */

import XCTest
@testable import Swiftgres

class CheckpointTests: XCTestCase {
    static var allTests = [
        ("testCheckpoint", testCheckpoint)
    ]
    
    func testCheckpoint() {
        let statement = PGStatement.checkpoint()
        XCTAssertEqual(try! statement.toSql(), "CHECKPOINT;")
    }
}
