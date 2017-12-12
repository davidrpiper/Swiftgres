/*
 *  Notify.swift
 *  Swiftgres
 *
 *  Copyright (c) 2018 David Piper, @_davidpiper
 *
 *  This software may be modified and distributed under the terms
 *  of the MIT license. See the LICENSE file for details.
 */

public extension PostgresStatement {
    public static func notify(_ channel: ColId, _ payload: String? = nil) -> NotifyStatement {
        return NotifyStatement(channel: channel, payload: payload)
    }
    
    public struct NotifyStatement: CommitablePostgresStatement {
        let channel: ColId
        let payload: String?
        
        public func toSql() throws -> String {
            let payloadSuffix: String
            if let str = payload {
                payloadSuffix = ", '\(str)'"
            } else {
                payloadSuffix = ""
            }
            
            return try "\(KW.NOTIFY) \(channel.sqlString())\(payloadSuffix);"
        }
	}
}
