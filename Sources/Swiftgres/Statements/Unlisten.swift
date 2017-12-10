/*
 *  Unlisten.swift
 *  Swiftgres
 *
 *  Copyright (c) 2018 David Piper, @_davidpiper
 *
 *  This software may be modified and distributed under the terms
 *  of the MIT license. See the LICENSE file for details.
 */

public extension PostgresStatement {
    public static func unlisten(_ channel: ColId) -> UnlistenStatement {
        return .channel(channel)
    }
    
    public static func unlistenAll() -> UnlistenStatement {
        return .all
    }
    
    public enum UnlistenStatement: CommitablePostgresStatement {
        case channel(ColId)
        case all
        
        public func toSql() throws -> String {
            switch self {
            case .channel(let channel):
                return try "\(KW.UNLISTEN) \(channel.sqlString());"
            case .all:
                return "\(KW.UNLISTEN) '*';"
            }
        }
	}
}
