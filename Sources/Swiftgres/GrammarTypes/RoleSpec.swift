/*
 *  RoleSpec.swift
 *  Swiftgres
 *
 *  Copyright (c) 2018 David Piper, @_davidpiper
 *
 *  This software may be modified and distributed under the terms
 *  of the MIT license. See the LICENSE file for details.
 */

public enum RoleSpec: PostgresGrammarType, ExpressibleByStringLiteral {
    case newOwner(Identifier)
    case currentUser
    case sessionUser
    
    public init(stringLiteral value: String) {
        self.init(value)
    }
    
    public init(_ stringValue: String) {
        if stringValue == "CURRENT_USER" {
            self = .currentUser
        } else if stringValue == "SESSION_USER" {
            self = .sessionUser
        } else {
            self = .newOwner(Identifier(stringValue))
        }
    }
    
    public var description: String {
        switch self {
        case .newOwner(let owner): return "\(owner)"
        case .currentUser: return "CURRENT_USER"
        case .sessionUser: return "SESSION_USER"
        }
    }
    
    public func isValid() -> Bool {
        if case .newOwner(let owner) = self {
            return owner.isValid() && !ReservedHelper.isReserved(keyword: "\(owner)")
        }
        
        return true
    }
}

public struct RoleList: PostgresGrammarType, ExpressibleByArrayLiteral {
    private let roles: [RoleSpec]
    
    public init(arrayLiteral elements: RoleSpec...) {
        self.init(elements)
    }
    
    public init(_ roles: [RoleSpec]) {
        self.roles = roles
    }
    
    public var description: String {
        return roles.map { "\($0)" }.joined(separator: ",")
    }
    
    public func isValid() -> Bool {
        return ValidArrayHelper.isValidAndNotEmpty(roles)
    }
}
