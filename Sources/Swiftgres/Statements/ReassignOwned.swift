/*
 *  ReassignOwned.swift
 *  Swiftgres
 *
 *  Copyright (c) 2018 David Piper, @_davidpiper
 *
 *  This software may be modified and distributed under the terms
 *  of the MIT license. See the LICENSE file for details.
 */

// TODO: Tests
public extension PostgresStatement {
    public static func reassignOwned(by: RoleList, to: RoleSpec) -> ReassignOwnedStatement {
        return ReassignOwnedStatement(list: by, toRole: to)
    }
    
    public struct ReassignOwnedStatement: CommitablePostgresStatement {
        let list: RoleList
        let toRole: RoleSpec
        
        public func toSql() throws -> String {
            return try "\(KW.REASSIGN) \(KW.OWNED) \(KW.BY) \(list.sqlString()) \(KW.TO) \(toRole.sqlString());"
        }
	}
}
