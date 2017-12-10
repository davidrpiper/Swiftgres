/*
 *  ListenStmt.swift
 *  Swiftgres
 *
 *  Copyright (c) 2018 David Piper, @_davidpiper
 *
 *  This software may be modified and distributed under the terms
 *  of the MIT license. See the LICENSE file for details.
 */

public extension PostgresStatement {
    public static func listen(_ channel: ColId) -> ListenStatement {
        return ListenStatement(channel: channel)
    }
    
    public struct ListenStatement: CommitablePostgresStatement {
        let channel: ColId
        
        public func toSql() throws -> String {
            return try "\(KW.LISTEN) \(channel.sqlString())"
        }
	}
}
