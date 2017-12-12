/*
 *  DropAssert.swift
 *  Swiftgres
 *
 *  Copyright (c) 2018 David Piper, @_davidpiper
 *
 *  This software may be modified and distributed under the terms
 *  of the MIT license. See the LICENSE file for details.
 */

// TODO: Tests
public extension PostgresStatement {
    public static func dropAssertion(_ name: Name, _ dropBehavior: DropBehavior? = nil) -> DropAssertStatement {
        return DropAssertStatement(name: name, dropBehavior: dropBehavior)
    }
    
    public struct DropAssertStatement: CommitablePostgresStatement {
        let name: Name
        let dropBehavior: DropBehavior?
        
        public func toSql() throws -> String {
            let behaviorSuffix: String
            if let behavior = dropBehavior {
                behaviorSuffix = try " \(behavior.sqlString())"
            } else {
                behaviorSuffix = ""
            }
            
            return try "\(KW.DROP) \(KW.ASSERTION) \(name.sqlString())\(behaviorSuffix);"
        }
	}
}
