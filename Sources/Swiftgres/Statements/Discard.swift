/*
 *  Discard.swift
 *  Swiftgres
 *
 *  Copyright (c) 2018 David Piper, @_davidpiper
 *
 *  This software may be modified and distributed under the terms
 *  of the MIT license. See the LICENSE file for details.
 */

public extension PostgresStatement {
    public static func discard(_ kind: DiscardKind) -> DiscardStatement {
        return DiscardStatement(kind: kind)
    }
    
    public enum DiscardKind {
        case all
        case temp
        case temporary
        case plans
        case sequences
    }
    
    public struct DiscardStatement: CommitablePostgresStatement {
        let kind: DiscardKind
        
        public func toSql() throws -> String {
            switch kind {
            case .all:
                return "\(KW.DISCARD) \(KW.ALL);"
            case .temp:
                return "\(KW.DISCARD) \(KW.TEMP);"
            case .temporary:
                return "\(KW.DISCARD) \(KW.TEMPORARY);"
            case .plans:
                return "\(KW.DISCARD) \(KW.PLANS);"
            case .sequences:
                return "\(KW.DISCARD) \(KW.SEQUENCES);"
            }
        }
	}
}
