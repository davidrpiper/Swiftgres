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
        return VariableShowStatement(property: .variable(varName))
    }
    
    public static func show(_ what: ShowProperty) -> VariableShowStatement {
        return VariableShowStatement(property: what)
    }
    
    public enum ShowProperty {
        case timezone
        case transactionIsolationLevel
        case session
        case authorization
        case all
        case variable(VarName)
    }
    
    public struct VariableShowStatement: CommitablePostgresStatement {
        let property: ShowProperty
        
        public func toSql() throws -> String {
            switch property {
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
