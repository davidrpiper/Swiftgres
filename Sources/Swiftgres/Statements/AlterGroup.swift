/*
 *  AlterGroup.swift
 *  Swiftgres
 *
 *  Copyright (c) 2018 David Piper, @_davidpiper
 *
 *  This software may be modified and distributed under the terms
 *  of the MIT license. See the LICENSE file for details.
 */

// TODO: Tests
public extension PostgresStatement {
    public func alterGroup(_ group: RoleSpec, addUser roles: RoleList) -> AlterGroupStatement {
        return .addRoles(toGroup: group, roles: roles)
    }
    
    public func alterGroup(_ group: RoleSpec, addUser role: RoleSpec) -> AlterGroupStatement {
        return .addRoles(toGroup: group, roles: [role])
    }
    
    public func alterGroup(_ group: RoleSpec, dropUser roles: RoleList) -> AlterGroupStatement {
        return .dropRoles(fromGroup: group, roles: roles)
    }
    
    public func alterGroup(_ group: RoleSpec, dropUser role: RoleSpec) -> AlterGroupStatement {
        return .dropRoles(fromGroup: group, roles: [role])
    }
    
    public enum AlterGroupStatement: CommitablePostgresStatement {
        case addRoles(toGroup: RoleSpec, roles: RoleList)
		case dropRoles(fromGroup: RoleSpec, roles: RoleList)
        
        public func toSql() throws -> String {
            switch self {
            case .addRoles(let toGroup, let roles):
                return try "\(KW.ALTER) \(KW.GROUP) \(toGroup.sqlString()) \(KW.ADD) \(KW.USER) \(roles.sqlString());"
            case .dropRoles(let fromGroup, let roles):
                return try "\(KW.ALTER) \(KW.GROUP) \(fromGroup.sqlString()) \(KW.DROP) \(KW.USER) \(roles.sqlString());"
            }
        }
	}
}
