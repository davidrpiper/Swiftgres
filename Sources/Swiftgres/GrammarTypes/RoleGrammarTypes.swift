/*
 *  RoleGrammarTypes.swift
 *  Swiftgres
 *
 *  Copyright (c) 2018 David Piper, @_davidpiper
 *
 *  This software may be modified and distributed under the terms
 *  of the MIT license. See the LICENSE file for details.
 */

public enum RoleSpec: PostgresGrammarType, ExpressibleByStringLiteral {
    case role(Identifier)
    case currentUser
    case sessionUser
    
    public init(stringLiteral value: String) {
        self.init(value)
    }
    
    public init(_ stringValue: String) {
        if stringValue == "\(KW.CURRENT_USER)" {
            self = .currentUser
        } else if stringValue == "\(KW.SESSION_USER)" {
            self = .sessionUser
        } else {
            self = .role(Identifier(stringValue))
        }
    }
    
    public var description: String {
        switch self {
        case .role(let role): return "\(role)"
        case .currentUser: return "\(KW.CURRENT_USER)"
        case .sessionUser: return "\(KW.SESSION_USER)"
        }
    }
    
    public func isValid() -> Bool {
        if case .role(let role) = self {
            return role.isValid() && !ReservedHelper.isReserved(keyword: "\(role)")
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

public enum CreateRoleOption: PostgresGrammarType {
    case password(String)
    case passwordNull
    case encryptedPassword(String)
    case unencryptedPassword(String)
    case inherit
    case connectionLimit(Int64)
    case validUntil(String)
    case user(RoleList)
    case sysId(Int64)
    case admin(RoleList)
    case role(RoleList)
    case inRole(RoleList)
    case inGroup(RoleList)
    
    public var description: String {
        switch self {
        case .password(let password):
            return "\(KW.PASSWORD) '\(password)'"
        case .passwordNull:
            return "\(KW.PASSWORD) \(KW.NULL)"
        case .encryptedPassword(let encryptedPassword):
            return "\(KW.ENCRYPTED) \(KW.PASSWORD) '\(encryptedPassword)'"
        case .unencryptedPassword(let password):
            return "\(KW.UNENCRYPTED) \(KW.PASSWORD) '\(password)'"
        case .inherit:
            return "\(KW.INHERIT)"
        case .connectionLimit(let limit):
            return "\(KW.CONNECTION) \(KW.LIMIT) \(limit)"
        case .validUntil(let sconst):
            return "\(KW.VALID) \(KW.UNTIL) '\(sconst)'"
        case .user(let roleList):
            return "\(KW.USER) \(roleList)"
        case .sysId(let sysId):
            return "\(KW.SYSID) \(sysId)"
        case .admin(let roleList):
            return "\(KW.ADMIN) \(roleList)"
        case .role(let roleList):
            return "\(KW.ROLE) \(roleList)"
        case .inRole(let roleList):
            return "\(KW.IN) \(KW.ROLE) \(roleList)"
        case .inGroup(let roleList):
            return "\(KW.IN) \(KW.GROUP) \(roleList)"
        }
    }
    
    public func isValid() -> Bool {
        switch self {
        case .password(_):
            return true
        case .passwordNull:
            return true
        case .encryptedPassword(_):
            return true
        case .unencryptedPassword(_):
            return true
        case .inherit:
            return true
        case .connectionLimit(_):
            return true
        case .validUntil(_):
            return true
        case .user(let roleList):
            return roleList.isValid()
        case .sysId(_):
            return true
        case .admin(let roleList):
            return roleList.isValid()
        case .role(let roleList):
            return roleList.isValid()
        case .inRole(let roleList):
            return roleList.isValid()
        case .inGroup(let roleList):
            return roleList.isValid()
        }
    }
}

// This struct deviates from the grammar naming, it's a bit confusing when we already
// have RoleList, and "Opt" can mean Optional, as well as Options. This struct matches
// the grammar type "OptRoleList"
public struct CreateRoleOptionList: PostgresGrammarType, ExpressibleByArrayLiteral {
    private let options: [CreateRoleOption]
    
    public init(arrayLiteral elements: CreateRoleOption...) {
        self.init(elements)
    }
    
    public init(_ options: [CreateRoleOption]) {
        self.options = options
    }
    
    public var description: String {
        return options.map { "\($0)"}.joined(separator: " ")
    }
    
    public func isValid() -> Bool {
        return ValidArrayHelper.isValid(options)
    }
}
