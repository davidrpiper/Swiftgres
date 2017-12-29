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
    case set(SetRest)
    case reset(ResetRest)
    
    public var description: String {
        switch self {
        case .set(let setRest): return "\(KW.SET) \(setRest)"
        case .reset(let resetRest): return "\(KW.RESET) \(resetRest)"
        }
    }
    
    public func isValid() -> Bool {
        switch self {
        case .set(let setRest): return setRest.isValid()
        case .reset(let resetRest): return resetRest.isValid()
        }
    }
}

public enum SetRest: PostgresGrammarType {
    case transaction(TransactionModeList)
    case sessionCharacteristicsAsTransaction(TransactionModeList)
    case variableFromCurrent(VarName)
    case timeZone(String) // TODO? A little loosely typed...
    case catalog(String)
    case schema(String)
    case names
    case namesWithEncoding(String)
    case role(String)
    case sessionAuthorization(String)
    case sessionAuthorizationDefault
    case xmlOption // TODO
    case transactionSnapshot(String)
    case variable(VarName, to: VarList)
    case variableToDefault(VarName)
    
    public var description: String {
        switch self {
        case .transaction(let transactionModeList):
            return ""
        case .sessionCharacteristicsAsTransaction(let transactionModeList):
            return ""
        case .variableFromCurrent(let varName):
            return ""
        case .timeZone(let tz):
            return ""
        case .catalog(let catalogString):
            return ""
        case .schema(let schemaString):
            return ""
        case .names:
            return ""
        case .namesWithEncoding(let encodingString):
            return ""
        case .role(let roleString):
            return ""
        case .sessionAuthorization(let saString):
            return ""
        case .sessionAuthorizationDefault:
            return ""
        case .xmlOption:
            return "" // TODO
        case .transactionSnapshot(let snapshotString):
            return ""
        case .variable(let varName, let varList):
            return ""
        case .variableToDefault(let varName):
            return ""
        }
    }
    
    public func isValid() -> Bool {
        switch self {
        case .transaction(let transactionModeList):
            return transactionModeList.isValid()
        case .sessionCharacteristicsAsTransaction(let transactionModeList):
            return transactionModeList.isValid()
        case .variableFromCurrent(let varName):
            return varName.isValid()
        case .timeZone(_):
            return true
        case .catalog(_):
            return true
        case .schema(_):
            return true
        case .names:
            return true
        case .namesWithEncoding(_):
            return true
        case .role(_):
            return true
        case .sessionAuthorization(_):
            return true
        case .sessionAuthorizationDefault:
            return true
        case .xmlOption:
            return false // TODO
        case .transactionSnapshot(_):
            return true
        case .variable(let varName, let varList):
            return varName.isValid() && varList.isValid()
        case .variableToDefault(let varName):
            return varName.isValid()
        }
    }
}

public enum ResetRest: PostgresGrammarType {
    case timeZone
    case transactionIsolationLevel
    case sessionAuthorization
    case all
    case variable(VarName)
    
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
        case .variable(let varName):
            return "\(varName)"
        }
    }
    
    public func isValid() -> Bool {
        switch self {
        case .variable(let varName): return varName.isValid()
        default: return true
        }
    }
}
