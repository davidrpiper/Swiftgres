/*
 *  ClosePortal.swift
 *  Swiftgres
 *
 *  Copyright (c) 2018 David Piper, @_davidpiper
 *
 *  This software may be modified and distributed under the terms
 *  of the MIT license. See the LICENSE file for details.
 */

public extension PostgresStatement {
    public static func close(_ cursorName: CursorName) -> ClosePortalStatement {
        return .cursor(cursorName)
    }
    
    public static func closeAll() -> ClosePortalStatement {
        return .all
    }
    
    public enum ClosePortalStatement: CommitablePostgresStatement {
        case cursor(CursorName)
        case all
        
        public func toSql() throws -> String {
            switch self {
            case .cursor(let cursor):
                return try "\(KW.CLOSE) \(cursor.sqlString());"
            case .all:
                return "\(KW.CLOSE) \(KW.ALL);"
            }
        }
	}
}
