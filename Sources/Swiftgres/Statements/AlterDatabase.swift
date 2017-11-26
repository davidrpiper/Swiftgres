/*
 *  AlterDatabase.swift
 *  Swiftgres
 *
 *  Copyright (c) 2018 David Piper, @_davidpiper
 *
 *  This software may be modified and distributed under the terms
 *  of the MIT license. See the LICENSE file for details.
 */

public extension PostgresStatement {
    
    private struct AlterDatabaseRenameTo: CommitablePostgresStatement {
        let dbName: DatabaseName
        let toName: DatabaseName
        
        public func toSql() throws -> String {
            return try "\(KW.ALTER) \(KW.DATABASE) \(dbName.sqlString()) \(KW.RENAME) \(KW.TO) \(toName.sqlString());"
        }
    }
    
    private struct AlterDatabaseOwnerTo: CommitablePostgresStatement {
        let dbName: DatabaseName
        let owner: RoleSpec
        
        public func toSql() throws -> String {
            return try "\(KW.ALTER) \(KW.DATABASE) \(dbName.sqlString()) \(KW.OWNER) \(KW.TO) \(owner.sqlString());"
        }
    }
    
    private struct AlterDatabaseWith: CommitablePostgresStatement {
        let dbName: DatabaseName
        let createDbOptList: CreateDbOptList
        
        public func toSql() throws -> String {
            return try "\(KW.ALTER) \(KW.DATABASE) \(dbName.sqlString()) \(KW.WITH) \(createDbOptList.sqlString());"
        }
    }
    
    private struct AlterDatabaseOpts: CommitablePostgresStatement {
        let dbName: DatabaseName
        let createDbOptList: CreateDbOptList
        
        public func toSql() throws -> String {
            return try "\(KW.ALTER) \(KW.DATABASE) \(dbName.sqlString()) \(createDbOptList.sqlString());"
        }
    }
    
    private struct AlterDatabaseSetTablespace: CommitablePostgresStatement {
        let dbName: DatabaseName
        let tablespace: Name
        
        public func toSql() throws -> String {
            return try "\(KW.ALTER) \(KW.DATABASE) \(dbName.sqlString()) \(KW.SET) \(KW.TABLESPACE) \(tablespace.sqlString());"
        }
    }
    
    private struct AlterDatabaseSetReset: CommitablePostgresStatement {
        let dbName: DatabaseName
        let setReset: SetResetClause
        
        public func toSql() throws -> String {
            return try "\(KW.ALTER) \(KW.DATABASE) \(dbName.sqlString()) \(setReset.sqlString());"
        }
    }
    
	public struct AlterDatabase {
        private let dbName: DatabaseName
        
        public init(_ dbName: DatabaseName) {
            self.dbName = dbName
        }
        
        public func renameTo(_ toName: DatabaseName) -> CommitablePostgresStatement {
            return AlterDatabaseRenameTo(dbName: dbName, toName: toName)
        }
        
        public func ownerTo(_ owner: RoleSpec) -> CommitablePostgresStatement {
            return AlterDatabaseOwnerTo(dbName: dbName, owner: owner)
        }
        
        public func with(_ createDbOptList: CreateDbOptList) -> CommitablePostgresStatement {
            return AlterDatabaseWith(dbName: dbName, createDbOptList: createDbOptList)
        }
        
        public func opts(_ createDbOptList: CreateDbOptList) -> CommitablePostgresStatement {
            return AlterDatabaseOpts(dbName: dbName, createDbOptList: createDbOptList)
        }
        
        public func setTablespace(_ name: Name) -> CommitablePostgresStatement {
            return AlterDatabaseSetTablespace(dbName: dbName, tablespace: name)
        }
        
        public func setResetClause(_ setResetClause: SetResetClause) -> CommitablePostgresStatement {
            return AlterDatabaseSetReset(dbName: dbName, setReset: setResetClause)
        }
    }
}
