/*
 *  Do.swift
 *  Swiftgres
 *
 *  Copyright (c) 2018 David Piper, @_davidpiper
 *
 *  This software may be modified and distributed under the terms
 *  of the MIT license. See the LICENSE file for details.
 */

// TODO: Tests
public extension PostgresStatement {
    public static func DO(_ code: String) -> DoStatement {
        return .noLang(code: code)
    }
    
    public static func DO(language: String, _ code: String) -> DoStatement {
        return .with(language: language, code: code)
    }
    
    public enum DoStatement: CommitablePostgresStatement {
        case noLang(code: String)
        case with(language: String, code: String)
        
        public func toSql() throws -> String {
            switch self {
            case .noLang(let code):
                return "\(KW.DO) $$\(code)$$;"
            case .with(let language, let code):
                return "\(KW.DO) \(KW.LANGUAGE) \(language) $$\(code)$$;"
            }
        }
	}
}
