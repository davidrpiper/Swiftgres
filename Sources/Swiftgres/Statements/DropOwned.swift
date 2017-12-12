/*
 *  DropOwned.swift
 *  Swiftgres
 *
 *  Copyright (c) 2018 David Piper, @_davidpiper
 *
 *  This software may be modified and distributed under the terms
 *  of the MIT license. See the LICENSE file for details.
 */

// TODO: Tests
public extension PostgresStatement {
    public func dropOwnedBy(_ roleList: RoleList, _ dropBehavior: DropBehavior? = nil) -> DropOwnedStatement {
        return DropOwnedStatement(roleList: roleList, dropBehavior: dropBehavior)
    }
    
    public struct DropOwnedStatement: CommitablePostgresStatement {
        let roleList: RoleList
        let dropBehavior: DropBehavior?
        
        public func toSql() throws -> String {
            let behaviorSuffix: String
            if let behavior = dropBehavior {
                behaviorSuffix = try " \(behavior.sqlString())"
            } else {
                behaviorSuffix = ""
            }
            
            return try "\(KW.DROP) \(KW.OWNED) \(KW.BY) \(roleList.sqlString())\(behaviorSuffix);"
        }
	}
}
