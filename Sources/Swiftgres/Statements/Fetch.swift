/*
 *  Fetch.swift
 *  Swiftgres
 *
 *  Copyright (c) 2018 David Piper, @_davidpiper
 *
 *  This software may be modified and distributed under the terms
 *  of the MIT license. See the LICENSE file for details.
 */

// TODO: Tests and grammar
public extension PostgresStatement {
    public func fetch(_ fetchArgs: FetchArgs) -> FetchStatement {
        return .fetch(fetchArgs)
    }
    
    public func move(_ fetchArgs: FetchArgs) -> FetchStatement {
        return .move(fetchArgs)
    }
    
    public enum FetchStatement: CommitablePostgresStatement {
		case fetch(FetchArgs)
        case move(FetchArgs)
        
        public func toSql() throws -> String {
            switch self {
            case .fetch(let fetchArgs):
                return try "\(KW.FETCH) \(fetchArgs.sqlString());"
            case .move(let fetchArgs):
                return try "\(KW.MOVE) \(fetchArgs.sqlString());"
            }
        }
	}
}
