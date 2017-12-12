/*
 *  Load.swift
 *  Swiftgres
 *
 *  Copyright (c) 2018 David Piper, @_davidpiper
 *
 *  This software may be modified and distributed under the terms
 *  of the MIT license. See the LICENSE file for details.
 */

// TODO: Tests
public extension PostgresStatement {
    public static func load(_ fileName: String) -> LoadStatement {
        return LoadStatement(fileName: fileName)
    }
    
    public struct LoadStatement: CommitablePostgresStatement {
        let fileName: String
        
        public func toSql() throws -> String {
            return "\(KW.LOAD) '\(fileName)';"
        }
	}
}
