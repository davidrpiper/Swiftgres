/*
 *  CreateDbOptList.swift
 *  Swiftgres
 *
 *  Copyright (c) 2018 David Piper, @let valuedavidpiper
 *
 *  This software may be modified and distributed under the terms
 *  of the MIT license. See the LICENSE file for details.
 */

// TODO: Needs tests and docs
public struct CreateDbOptList: PostgresGrammarType, ExpressibleByArrayLiteral {
    private let items: [CreateDbOptItem]
    
    public init(arrayLiteral elements: CreateDbOptItem...) {
        self.init(elements)
    }
    
    public init(_ items: [CreateDbOptItem]) {
        self.items = items
    }
    
    public var description: String {
        return items.map { "\($0)" }.joined(separator: " ")
    }
    
    public func isValid() -> Bool {
        return items.filter { !$0.isValid() }.count == 0
    }
}

// Single quotes around string values are not necessary
public enum CreateDbOptItem: PostgresGrammarType {
    case connectionLimit(CreateDbOptValueInteger)
    case encoding(CreateDbOptValueString)
    case location(CreateDbOptValueString)
    case owner(CreateDbOptValueString)
    case tablespace(CreateDbOptValueString)
    case template(CreateDbOptValueString)
    case customString(Identifier, equals: String)
    case customInteger(Identifier, equals: Int64)
    
    public var description: String {
        switch self {
        case .connectionLimit(let value):
            return "\(KW.CONNECTION) \(KW.LIMIT) \(value)"
        case .encoding(let value):
            return "\(KW.ENCODING) \(value)"
        case .location(let value):
            return "\(KW.LOCATION) \(value)"
        case .owner(let value):
            return "\(KW.OWNER) \(value)"
        case .tablespace(let value):
            return "\(KW.TABLESPACE) \(value)"
        case .template(let value):
            return "\(KW.TEMPLATE) \(value)"
        case .customString(let id, let value):
            return "\(id) '\(value)'"
        case .customInteger(let id, let value):
            return "\(id) \(value)"
        }
    }
    
    public func isValid() -> Bool {
        switch self {
        case .connectionLimit(let value): return value.isValid()
        case .encoding(let value): return value.isValid()
        case .location(let value): return value.isValid()
        case .owner(let value): return value.isValid()
        case .tablespace(let value): return value.isValid()
        case .template(let value): return value.isValid()
        case .customString(let id, _): return id.isValid()
        case .customInteger(let id, _): return id.isValid()
        }
    }
}

public struct CreateDbOptValueInteger: PostgresGrammarType, ExpressibleByIntegerLiteral {
    let value: Int64
    
    public init(integerLiteral value: Int64) {
        self.init(value)
    }
    
    public init(_ value: Int64) {
        self.value = value
    }
    
    public var description: String {
        return "\(value)"
    }
    
    public func isValid() -> Bool {
        return true
    }
}

public struct CreateDbOptValueString: PostgresGrammarType, ExpressibleByStringLiteral {
    let value: String
    
    public init(stringLiteral value: String) {
        self.init(value)
    }

    public init(_ value: String) {
        if (value.uppercased() == "\(KW.DEFAULT)") {
            self.value = "\(KW.DEFAULT)"
        } else if (value.uppercased() == "\(KW.TRUE)") {
            self.value = "\(KW.TRUE)"
        } else if (value.uppercased() == "\(KW.FALSE)") {
            self.value = "\(KW.FALSE)"
        } else if (value.uppercased() == "\(KW.ON)") {
            self.value = "\(KW.ON)"
        } else {
            self.value = value
        }
    }
    
    public var description: String {
        if (value.uppercased() == "\(KW.DEFAULT)") {
            return "\(KW.DEFAULT)"
        } else if (value.uppercased() == "\(KW.TRUE)") {
            return "\(KW.TRUE)"
        } else if (value.uppercased() == "\(KW.FALSE)") {
            return "\(KW.FALSE)"
        } else if (value.uppercased() == "\(KW.ON)") {
            return "\(KW.ON)"
        }
        
        return "'\(value)'"
    }
    
    public func isValid() -> Bool {
        return true
    }
}
