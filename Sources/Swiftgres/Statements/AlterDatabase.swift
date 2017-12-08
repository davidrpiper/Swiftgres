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
    public static func alterDatabase(_ dbName: DatabaseName, renameTo toName: DatabaseName) -> AlterDatabaseStatement {
        return .renameTo(dbName, toName: toName)
    }
    
    public static func alterDatabase(_ dbName: DatabaseName, ownerTo owner: RoleSpec) -> AlterDatabaseStatement {
        return .ownerTo(dbName, owner: owner)
    }
    
    public static func alterDatabase(_ dbName: DatabaseName, with optList: CreateDbOptList) -> AlterDatabaseStatement {
        return .with(dbName, optList: optList)
    }
    
    public static func alterDatabase(_ dbName: DatabaseName, _ optList: CreateDbOptList) -> AlterDatabaseStatement {
        return .with(dbName, optList: optList)
    }
    
    public static func alterDatabase(_ dbName: DatabaseName, setTableSpace tablespace: Name) -> AlterDatabaseStatement {
        return .setTablespace(dbName, tablespace: tablespace)
    }
    
    public static func alterDatabase(_ dbName: DatabaseName, setResetClause clause: SetResetClause) -> AlterDatabaseStatement {
        return .setResetClause(dbName, clause: clause)
    }
    
    public enum AlterDatabaseStatement: CommitablePostgresStatement {
        case renameTo(DatabaseName, toName: DatabaseName)
        case ownerTo(DatabaseName, owner: RoleSpec)
        case with(DatabaseName, optList: CreateDbOptList)
        case setTablespace(DatabaseName, tablespace: Name)
        case setResetClause(DatabaseName, clause: SetResetClause)
        
        public func toSql() throws -> String {
            switch self {
            case .renameTo(let dbName, let toName):
                return try "\(KW.ALTER) \(KW.DATABASE) \(dbName.sqlString()) \(KW.RENAME) \(KW.TO) \(toName.sqlString());"
            case .ownerTo(let dbName, let owner):
                return try "\(KW.ALTER) \(KW.DATABASE) \(dbName.sqlString()) \(KW.OWNER) \(KW.TO) \(owner.sqlString());"
            case .with(let dbName, let optList):
                return try "\(KW.ALTER) \(KW.DATABASE) \(dbName.sqlString()) \(KW.WITH) \(optList.sqlString());"
            case .setTablespace(let dbName, let tablespace):
                return try "\(KW.ALTER) \(KW.DATABASE) \(dbName.sqlString()) \(KW.SET) \(KW.TABLESPACE) \(tablespace.sqlString());"
            case .setResetClause(let dbName, let clause):
                return try "\(KW.ALTER) \(KW.DATABASE) \(dbName.sqlString()) \(clause.sqlString());"
            }
        }
    }
}
