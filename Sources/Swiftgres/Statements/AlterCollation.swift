/*
 *  AlterCollation.swift
 *  Swiftgres
 *
 *  Copyright (c) 2018 David Piper, @_davidpiper
 *
 *  This software may be modified and distributed under the terms
 *  of the MIT license. See the LICENSE file for details.
 */

public extension PostgresStatement {
    
    private struct AlterCollationRefreshVersion: CommitablePostgresStatement {
        let name: AnyName
        
        public func toSql() throws -> String {
            return try "\(KW.ALTER) \(KW.COLLATION) \(name.sqlString()) \(KW.REFRESH) \(KW.VERSION);"
        }
    }
    
    private struct AlterCollationRenameTo: CommitablePostgresStatement {
        let name: AnyName
        let toName: Name
        
        public func toSql() throws -> String {
            return try "\(KW.ALTER) \(KW.COLLATION) \(name.sqlString()) \(KW.RENAME) \(KW.TO) \(toName.sqlString());"
        }
    }
    
    private struct AlterCollationOwnerTo: CommitablePostgresStatement {
        let name: AnyName
        let role: RoleSpec
        
        public func toSql() throws -> String {
            return try "\(KW.ALTER) \(KW.COLLATION) \(name.sqlString()) \(KW.OWNER) \(KW.TO) \(role.sqlString());"
        }
    }
    
    private struct AlterCollationSetSchema: CommitablePostgresStatement {
        let name: AnyName
        let schema: Name
        
        public func toSql() throws -> String {
            return try "\(KW.ALTER) \(KW.COLLATION) \(name.sqlString()) \(KW.SET) \(KW.SCHEMA) \(schema.sqlString());"
        }
    }
    
	public struct AlterCollation {
        private let name: AnyName
        
        public init(_ name: AnyName) {
            self.name = name
        }
        
        public func refreshVersion() -> CommitablePostgresStatement {
            return AlterCollationRefreshVersion(name: name)
        }
        
        public func renameTo(_ toName: Name) -> CommitablePostgresStatement {
            return AlterCollationRenameTo(name: name, toName: toName)
        }
        
        public func ownerTo(_ owner: RoleSpec) -> CommitablePostgresStatement {
            return AlterCollationOwnerTo(name: name, role: owner)
        }
        
        public func setSchema(_ schema: Name) -> CommitablePostgresStatement {
            return AlterCollationSetSchema(name: name, schema: schema)
        }
	}
}
