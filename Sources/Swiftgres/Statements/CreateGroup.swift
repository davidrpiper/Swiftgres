/*
 *  CreateGroup.swift
 *  Swiftgres
 *
 *  Copyright (c) 2018 David Piper, @_davidpiper
 *
 *  This software may be modified and distributed under the terms
 *  of the MIT license. See the LICENSE file for details.
 */

// TODO: Tests (same as CreateRole but with Group)
public extension PostgresStatement {
    public static func createGroup(_ group: RoleSpec, with opts: CreateRoleOptionList? = nil) -> CreateGroupStatement {
        return CreateGroupStatement(group: group, opts: opts)
    }
    
    public struct CreateGroupStatement: CommitablePostgresStatement {
        let group: RoleSpec
        let opts: CreateRoleOptionList?
        
        public func toSql() throws -> String {
            let optSuffix: String
            if let roleOpts = opts {
                optSuffix = try " \(KW.WITH) \(roleOpts.sqlString())"
            } else {
                optSuffix = ""
            }
            
            return try "\(KW.CREATE) \(KW.GROUP) \(group.sqlString())\(optSuffix);"
        }
    }
}
