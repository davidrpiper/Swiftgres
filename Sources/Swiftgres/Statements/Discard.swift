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
    public static func discardAll() -> DiscardStatement {
        return .all
    }
    
    public static func discardTemp() -> DiscardStatement {
        return .temp
    }
    
    public static func discardTemporary() -> DiscardStatement {
        return .temporary
    }
    
    public static func discardPlans() -> DiscardStatement {
        return .plans
    }
    
    public static func discardSequences() -> DiscardStatement {
        return .sequences
    }
    
    public enum DiscardStatement: CommitablePostgresStatement {
        case all
        case temp
        case temporary
        case plans
        case sequences
        
        public func toSql() throws -> String {
            switch self {
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
