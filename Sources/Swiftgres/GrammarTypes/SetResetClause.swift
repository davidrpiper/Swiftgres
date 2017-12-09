/*
 *  SetResetClause.swift
 *  Swiftgres
 *
 *  Copyright (c) 2018 David Piper, @_davidpiper
 *
 *  This software may be modified and distributed under the terms
 *  of the MIT license. See the LICENSE file for details.
 */

public enum SetResetClause: PostgresGrammarType {
    case SET(SetRest)
    case RESET(ResetRest)
    
    public var description: String {
        switch self {
        case .SET(let setRest): return "\(KW.SET) \(setRest)"
        case .RESET(let resetRest): return "\(KW.RESET) \(resetRest)"
        }
    }
    
    public func isValid() -> Bool {
        switch self {
        case .SET(let setRest): return setRest.isValid()
        case .RESET(let resetRest): return resetRest.isValid()
        }
    }
}

// TODO
public enum SetRest: PostgresGrammarType {
    public var description: String {
        return ""
    }
    
    public func isValid() -> Bool {
        return false
    }
}

public enum ResetRest: PostgresGrammarType {
    case timeZone
    case transactionIsolationLevel
    case sessionAuthorization
    case all
    case genericName(VarName)
    
    public var description: String {
        switch self {
        case .timeZone:
            return "\(KW.TIME) \(KW.ZONE)"
        case .transactionIsolationLevel:
            return "\(KW.TRANSACTION) \(KW.ISOLATION) \(KW.LEVEL)"
        case .sessionAuthorization:
            return "\(KW.SESSION) \(KW.AUTHORIZATION)"
        case .all:
            return "\(KW.ALL)"
        case .genericName(let varName):
            return "\(varName)"
        }
    }
    
    public func isValid() -> Bool {
        switch self {
        case .genericName(let varName): return varName.isValid()
        default: return true
        }
    }
}
