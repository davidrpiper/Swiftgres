/*
 *  DropDatabase.swift
 *  Swiftgres
 *
 *  Copyright (c) 2018 David Piper, @_davidpiper
 *
 *  This software may be modified and distributed under the terms
 *  of the MIT license. See the LICENSE file for details.
 */

public extension PostgresStatement {
    public static func dropDatabase(_ name: DatabaseName) -> DropDatabaseStatement {
        return .drop(name)
    }
    
    public static func dropDatabaseIfExists(_ name: DatabaseName) -> DropDatabaseStatement {
        return .dropIfExists(name)
    }
    
    public enum DropDatabaseStatement: CommitablePostgresStatement {
		case drop(DatabaseName)
        case dropIfExists(DatabaseName)
        
        public func toSql() throws -> String {
            switch self {
            case .drop(let name):
                return try "\(KW.DROP) \(KW.DATABASE) \(name.sqlString());"
            case .dropIfExists(let name):
                return try "\(KW.DROP) \(KW.DATABASE) \(KW.IF) \(KW.EXISTS) \(name.sqlString());"
            }
        }
	}
}
