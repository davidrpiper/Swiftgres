/*
 *  CreateUser.swift
 *  Swiftgres
 *
 *  Copyright (c) 2018 David Piper, @_davidpiper
 *
 *  This software may be modified and distributed under the terms
 *  of the MIT license. See the LICENSE file for details.
 */

// TODO: Tests
public extension PostgresStatement {
    public static func createUser(_ role: RoleSpec, with opts: CreateRoleOptionList? = nil) -> CreateUserStatement {
        return CreateUserStatement(role: role, opts: opts)
    }
    
    public struct CreateUserStatement: CommitablePostgresStatement {
        let role: RoleSpec
        let opts: CreateRoleOptionList?
        
        public func toSql() throws -> String {
            let optSuffix: String
            if let roleOpts = opts {
                optSuffix = try " \(KW.WITH) \(roleOpts.sqlString())"
            } else {
                optSuffix = ""
            }
            
            return try "\(KW.CREATE) \(KW.USER) \(role.sqlString())\(optSuffix);"
        }
    }
}
