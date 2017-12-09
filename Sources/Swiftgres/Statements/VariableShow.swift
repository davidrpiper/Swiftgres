/*
 *  VariableShow.swift
 *  Swiftgres
 *
 *  Copyright (c) 2018 David Piper, @_davidpiper
 *
 *  This software may be modified and distributed under the terms
 *  of the MIT license. See the LICENSE file for details.
 */

public extension PostgresStatement {
    public static func show(_ varName: VarName) -> VariableShowStatement {
        return .variable(varName)
    }
    
    public static func showTimezone() -> VariableShowStatement {
        return .timezone
    }
    
    public static func showTransactionIsolationLevel() -> VariableShowStatement {
        return .transactionIsolationLevel
    }
    
    public static func showSession() -> VariableShowStatement {
        return .session
    }
    
    public static func showAuthorization() -> VariableShowStatement {
        return .authorization
    }
    
    public static func showAll() -> VariableShowStatement {
        return .all
    }
    
    public enum VariableShowStatement: CommitablePostgresStatement {
        case timezone
        case transactionIsolationLevel
        case session
        case authorization
        case all
        case variable(VarName)
        
        public func toSql() throws -> String {
            switch self {
            case .timezone:
                return "\(KW.SHOW) \(KW.TIME) \(KW.ZONE);"
            case .transactionIsolationLevel:
                return "\(KW.SHOW) \(KW.TRANSACTION) \(KW.ISOLATION) \(KW.LEVEL);"
            case .session:
                return "\(KW.SHOW) \(KW.SESSION);"
            case .authorization:
                return "\(KW.SHOW) \(KW.AUTHORIZATION);"
            case .all:
                return "\(KW.SHOW) \(KW.ALL);"
            case .variable(let varName):
                return try "\(KW.SHOW) \(varName.sqlString());"
            }
        }
	}
}
