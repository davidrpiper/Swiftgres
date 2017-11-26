/*
 *  SetResetClause.swift
 *  Swiftgres
 *
 *  Copyright (c) 2018 David Piper, @_davidpiper
 *
 *  This software may be modified and distributed under the terms
 *  of the MIT license. See the LICENSE file for details.
 */

// TODO
public enum SetResetClause: PostgresGrammarType {
    case SET(/*setRestMore*/ String)
    case RESET(/*resetRest*/ String)
    
    public var description: String {
        switch self {
        case .SET(let setRest): return "SET \(setRest)"
        case .RESET(let resetRest): return "RESET \(resetRest)"
        }
    }
    
    public func isValid() -> Bool {
        return false
        // switch self {
        // case .SET(let setRest): return false //setRest.isValid()
        // case .RESET(let resetRest): return false //resetRest.isValid()
        // }
    }
}
