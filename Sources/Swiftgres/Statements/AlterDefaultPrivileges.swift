/*
 * AlterDefaultPrivileges.swift
 *  Swiftgres
 *
 *  Copyright (c) 2018 David Piper, @_davidpiper
 *
 *  This software may be modified and distributed under the terms
 *  of the MIT license. See the LICENSE file for details.
 */

public extension PostgresStatement {
    public struct AlterDefaultPrivileges: CommitablePostgresStatement {
        private let defAclOptionList: DefAclOptionList
        private let defAclAction: DefAclAction
        
        public init(_ defAclOptionList: DefAclOptionList, _ defAclAction: DefAclAction) {
            self.defAclOptionList = defAclOptionList
            self.defAclAction = defAclAction
        }
        
        public func toSql() throws -> String {
            return try "\(KW.ALTER) \(KW.DEFAULT) \(KW.PRIVILEGES) \(defAclOptionList.sqlString()) \(defAclAction.sqlString())"
        }
	}
}
