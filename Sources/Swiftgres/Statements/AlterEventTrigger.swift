/*
 *  AlterEventTrigger.swift
 *  Swiftgres
 *
 *  Copyright (c) 2018 David Piper, @_davidpiper
 *
 *  This software may be modified and distributed under the terms
 *  of the MIT license. See the LICENSE file for details.
 */

public extension PostgresStatement {
    public static func alterEventTrigger(_ name: Name, _ enableTrigger: EnableTrigger) -> AlterEventTriggerStatement {
        return AlterEventTriggerStatement(name: name, enableTrigger: enableTrigger)
    }
    
    public struct AlterEventTriggerStatement: CommitablePostgresStatement {
        let name: Name
        let enableTrigger: EnableTrigger
        
        public func toSql() throws -> String {
            return try "\(KW.ALTER) \(KW.EVENT) \(KW.TRIGGER) \(name.sqlString()) \(enableTrigger.sqlString());"
        }
	}
}
