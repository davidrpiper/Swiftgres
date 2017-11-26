/*
 *  ColIdTests.swift
 *  Swiftgres
 *
 *  Copyright (c) 2018 David Piper, @_davidpiper
 *
 *  This software may be modified and distributed under the terms
 *  of the MIT license. See the LICENSE file for details.
 */

import XCTest
@testable import Swiftgres

class ColIdTests: XCTestCase {
    static var allTests = [
        ("testValidIdentifiersAreValidColIds", testValidIdentifiersAreValidColIds),
        ("testInvalidIdentifiersAreInvalidColIds", testInvalidIdentifiersAreInvalidColIds),
        ("testValidIdentifiersAreValidColIdWithAttrs", testValidIdentifiersAreValidColIdWithAttrs),
        ("testInvalidIdentifiersAreInvalidColIdWithAttrs", testInvalidIdentifiersAreInvalidColIdWithAttrs),
        ("testInvalidColIdsFromReservedKeywords", testInvalidColIdsFromReservedKeywords)
    ]
    
    func testValidIdentifiersAreValidColIds() {
        let colIds: [ColId] = ["abc", ColId("_def"), "_$_$", "_123"]
        assertColIdsAreValidIdentifiers(colIds)
        
        colIds.forEach { colId in
            XCTAssertTrue(colId.isValid())
        }
    }
    
    func testInvalidIdentifiersAreInvalidColIds() {
        let colIds: [ColId] = ["1abc", ColId(" _def"), "_$_$UPPER", "_1 23"]
        assertColIdsAreInvalidWithInvalidIdentifiers(colIds)
        
        colIds.forEach { colId in
            XCTAssertFalse(colId.isValid())
        }
    }
    
    func testValidIdentifiersAreValidColIdWithAttrs() {
        let colIdWithAttrsArray: [ColIdWithAttrs] = ["abc", "def.ghi", "_1.a2$.z"]
        
        colIdWithAttrsArray.forEach { colIdWithAttrs in
            XCTAssertTrue(colIdWithAttrs.isValid())
        }
    }
    
    func testInvalidIdentifiersAreInvalidColIdWithAttrs() {
        let colIdWithAttrsArray: [ColIdWithAttrs] = ["1abc", "def .ghi", "_1.a2$.UPPER.z"]
        
        colIdWithAttrsArray.forEach { colIdWithAttrs in
            XCTAssertFalse(colIdWithAttrs.isValid())
        }
    }
    
    func testInvalidColIdsFromReservedKeywords() {
        ReservedHelper.reservedKeywords.forEach { reservedKeyword in
            let colId = ColId(reservedKeyword)
            XCTAssertFalse(colId.isValid())
        }
    }
    
    func testInvalidColIdWithAttrsFromReservedKeywords() {
        ReservedHelper.reservedKeywords.forEach { reservedKeyword in
            let colId = ColIdWithAttrs("\(reservedKeyword).\(reservedKeyword)")
            XCTAssertFalse(colId.isValid())
        }
    }
    
    private func assertColIdsAreValidIdentifiers(_ colIds: [ColId]) {
        colIds.forEach { colId in
            XCTAssertTrue(Identifier("\(colId)").isValid())
        }
    }
    
    private func assertColIdsAreInvalidWithInvalidIdentifiers(_ colIds: [ColId]) {
        colIds.forEach { colId in
            XCTAssertFalse(Identifier("\(colId)").isValid())
        }
    }
}
