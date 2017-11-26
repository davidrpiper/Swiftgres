/*
 *  DefAclTypes.swift
 *  Swiftgres
 *
 *  Copyright (c) 2018 David Piper, @_davidpiper
 *
 *  This software may be modified and distributed under the terms
 *  of the MIT license. See the LICENSE file for details.
 */

public enum DefAclOption: PostgresGrammarType {
    case inSchema(NameList)
    case forRole(RoleList)
    case forUser(RoleList)
    
    public var description: String {
        switch self {
        case .inSchema(let nameList): return "\(KW.IN) \(KW.SCHEMA) \(nameList)"
        case .forRole(let roleList): return "\(KW.FOR) \(KW.ROLE) \(roleList)"
        case .forUser(let roleList): return "\(KW.FOR) \(KW.USER) \(roleList)"
        }
    }
    
    public func isValid() -> Bool {
        switch self {
        case .inSchema(let nameList): return nameList.isValid()
        case .forRole(let roleList): return roleList.isValid()
        case .forUser(let roleList): return roleList.isValid()
        }
    }
}

public struct DefAclOptionList: PostgresGrammarType, ExpressibleByArrayLiteral {
    private let options: [DefAclOption]
    
    public init(arrayLiteral elements: DefAclOption...) {
        self.init(elements)
    }
    
    public init(_ options: [DefAclOption]) {
        self.options = options
    }
    
    public var description: String {
        return options.map { "\($0)" }.joined(separator: " ")
    }
    
    public func isValid() -> Bool {
        return (options.filter { !$0.isValid() }.count == 0)
    }
}

// TODO
public enum DefAclAction: PostgresGrammarType {
    public var description: String {
        return ""
    }
    
    public func isValid() -> Bool {
        return false
    }
}
