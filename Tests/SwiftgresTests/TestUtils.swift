/*
 *  TestUtils.swift
 *  Swiftgres
 *
 *  Copyright (c) 2018 David Piper, @_davidpiper
 *
 *  This software may be modified and distributed under the terms
 *  of the MIT license. See the LICENSE file for details.
 */

@testable import Swiftgres

struct BadGrammar {
    static func anyName() -> AnyName {
        return AnyName("\(KW.ADMIN)")
    }
    
    static func name() -> Name {
        return Name(" ")
    }
    
    static func varName() -> VarName {
        return VarName("123")
    }
    
    static func cursorName() -> CursorName {
        return CursorName("$")
    }
    
    static func databaseName() -> DatabaseName {
        return DatabaseName(";")
    }
    
    static func colId() -> ColId {
        return ColId(" 1")
    }
}
