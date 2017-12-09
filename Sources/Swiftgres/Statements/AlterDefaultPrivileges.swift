/*
 *  AlterDefaultPrivileges.swift
 *  Swiftgres
 *
 *  Copyright (c) 2018 David Piper, @_davidpiper
 *
 *  This software may be modified and distributed under the terms
 *  of the MIT license. See the LICENSE file for details.
 */

// TODO: Grammar and tests
public extension PostgresStatement {
    public static func alterDefaultPrivileges(_ defAclOptionList: DefAclOptionList, _ defAclAction: DefAclAction) -> AlterDefaultPrivilegesStatement {
        return AlterDefaultPrivilegesStatement(defAclOptionList: defAclOptionList, defAclAction: defAclAction)
    }
    
    public struct AlterDefaultPrivilegesStatement: CommitablePostgresStatement {
        let defAclOptionList: DefAclOptionList
        let defAclAction: DefAclAction
        
        public func toSql() throws -> String {
            return try "\(KW.ALTER) \(KW.DEFAULT) \(KW.PRIVILEGES) \(defAclOptionList.sqlString()) \(defAclAction.sqlString())"
        }
    }
}
