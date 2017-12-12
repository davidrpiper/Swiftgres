/*
 *  VariableReset.swift
 *  Swiftgres
 *
 *  Copyright (c) 2018 David Piper, @_davidpiper
 *
 *  This software may be modified and distributed under the terms
 *  of the MIT license. See the LICENSE file for details.
 */

// TODO: Tests
public extension PostgresStatement {
    public static func reset(_ resetRest: ResetRest) -> VariableResetStatement {
        return VariableResetStatement(resetRest: resetRest)
    }
    
    public struct VariableResetStatement: CommitablePostgresStatement {
        let resetRest: ResetRest
        
        public func toSql() throws -> String {
            return try "\(KW.RESET) \(resetRest.sqlString());"
        }
	}
}
