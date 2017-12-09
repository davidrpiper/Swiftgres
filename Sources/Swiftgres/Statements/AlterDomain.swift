/*
 *  AlterDomain.swift
 *  Swiftgres
 *
 *  Copyright (c) 2018 David Piper, @_davidpiper
 *
 *  This software may be modified and distributed under the terms
 *  of the MIT license. See the LICENSE file for details.
 */

// TODO: Grammar and tests
public extension PostgresStatement {
    public static func alterDomain(_ domain: AnyName, _ alterColumnDefault: AlterColumnDefault) -> AlterDomainStatement {
        return .alterColumnDefault(domain: domain, alterColumnDefault: alterColumnDefault)
    }
    
    public static func alterDomain(_ domain: AnyName, add constraint: TableConstraint) -> AlterDomainStatement {
        return .addConstraint(domain: domain, constraint: constraint)
    }
    
    public static func alterDomain(_ domain: AnyName, dropConstraint constraint: Name, _ dropBehaviour: DropBehavior? = nil) -> AlterDomainStatement {
        return .dropConstraint(domain: domain, constraint: constraint, dropBehavior: dropBehaviour)
    }
    
    public static func alterDomain(_ domain: AnyName, dropConstraintIfExists constraint: Name, _ dropBehaviour: DropBehavior? = nil) -> AlterDomainStatement {
        return .dropConstraintIfExists(domain: domain, constraint: constraint, dropBehavior: dropBehaviour)
    }
    
    public static func alterDomain(_ domain: AnyName, validateConstraint constraint: Name) -> AlterDomainStatement {
        return .validateConstraint(domain: domain, constraint: constraint)
    }
    
    public static func alterDomain(_ domain: AnyName) -> AlterDomainNullStatements {
        return AlterDomainNullStatementsIntermediate(domain: domain)
    }
    
    public enum AlterDomainStatement: CommitablePostgresStatement {
        case alterColumnDefault(domain: AnyName, alterColumnDefault: AlterColumnDefault)
        case addConstraint(domain: AnyName, constraint: TableConstraint)
        case dropConstraint(domain: AnyName, constraint: Name, dropBehavior: DropBehavior?)
        case dropConstraintIfExists(domain: AnyName, constraint: Name, dropBehavior: DropBehavior?)
        case validateConstraint(domain: AnyName, constraint: Name)
        case dropNotNull(domain: AnyName)
        case setNotNull(domain: AnyName)
        
        public func toSql() throws -> String {
            switch self {
            case .alterColumnDefault(let domain, let alterColumnDefault):
                return try "\(KW.ALTER) \(KW.DOMAIN) \(domain.sqlString()) \(alterColumnDefault.sqlString());"
                
            case .addConstraint(let domain, let constraint):
                return try "\(KW.ALTER) \(KW.DOMAIN) \(domain.sqlString()) \(KW.ADD) \(constraint.sqlString());"
                
            case .dropConstraint(let domain, let constraint, let dropBehavior):
                let dropBehaviourSuffix: String
                if let behaviour = dropBehavior {
                    dropBehaviourSuffix = try " \(behaviour.sqlString())"
                } else {
                    dropBehaviourSuffix = ""
                }
                
                return try "\(KW.ALTER) \(KW.DOMAIN) \(domain.sqlString()) \(KW.DROP) \(KW.CONSTRAINT) \(constraint.sqlString())\(dropBehaviourSuffix);"
                
            case .dropConstraintIfExists(let domain, let constraint, let dropBehavior):
                let dropBehaviourSuffix: String
                if let behaviour = dropBehavior {
                    dropBehaviourSuffix = try " \(behaviour.sqlString())"
                } else {
                    dropBehaviourSuffix = ""
                }
                
                return try "\(KW.ALTER) \(KW.DOMAIN) \(domain.sqlString()) \(KW.DROP) \(KW.CONSTRAINT) \(KW.IF) \(KW.EXISTS) \(constraint.sqlString())\(dropBehaviourSuffix);"
                
            case .validateConstraint(let domain, let constraint):
                return try "\(KW.ALTER) \(KW.DOMAIN) \(domain.sqlString()) \(KW.VALIDATE) \(KW.CONSTRAINT) \(constraint.sqlString());"
                
            case .dropNotNull(let domain):
                return try "\(KW.ALTER) \(KW.DOMAIN) \(domain.sqlString()) \(KW.DROP) \(KW.NOT) \(KW.NULL);"
                
            case .setNotNull(let domain):
                return try "\(KW.ALTER) \(KW.DOMAIN) \(domain.sqlString()) \(KW.SET) \(KW.NOT) \(KW.NULL);"
            }
        }
	}
    
    public struct AlterDomainNullStatementsIntermediate: AlterDomainNullStatements {
        let domain: AnyName
        
        public func dropNotNull() -> AlterDomainStatement {
            return .dropNotNull(domain: domain)
        }
        
        public func setNotNull() -> AlterDomainStatement {
            return .setNotNull(domain: domain)
        }
    }
}

public protocol AlterDomainNullStatements {
    func dropNotNull() -> PostgresStatement.AlterDomainStatement
    func setNotNull() -> PostgresStatement.AlterDomainStatement
}
