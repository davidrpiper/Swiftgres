/*
 *  AlterCollation.swift
 *  Swiftgres
 *
 *  Copyright (c) 2018 David Piper, @_davidpiper
 *
 *  This software may be modified and distributed under the terms
 *  of the MIT license. See the LICENSE file for details.
 */

public extension PostgresStatement {
    public static func alterCollation(_ name: AnyName, renameTo toName: AnyName) -> AlterCollationStatement {
        return .renameTo(name, toName: toName)
    }
    
    public static func alterCollation(_ name: AnyName, ownerTo owner: RoleSpec) -> AlterCollationStatement {
        return .ownerTo(name, toRole: owner)
    }
    
    public static func alterCollation(_ name: AnyName, setSchema schema: Name) -> AlterCollationStatement {
        return .setSchema(name, schema: schema)
    }
    
    public static func alterCollation(_ name: AnyName) -> AlterCollationRefreshVersion {
        return AlterCollationRefreshVersionIntermediate(name: name)
    }
    
    public enum AlterCollationStatement: CommitablePostgresStatement {
        case renameTo(AnyName, toName: AnyName)
        case ownerTo(AnyName, toRole: RoleSpec)
        case setSchema(AnyName, schema: Name)
        case refreshVersion(AnyName)
        
        public func toSql() throws -> String {
            switch self {
            case .renameTo(let name, let toName):
                return try "\(KW.ALTER) \(KW.COLLATION) \(name.sqlString()) \(KW.RENAME) \(KW.TO) \(toName.sqlString());"
            case .ownerTo(let name, let toRole):
                return try "\(KW.ALTER) \(KW.COLLATION) \(name.sqlString()) \(KW.OWNER) \(KW.TO) \(toRole.sqlString());"
            case .setSchema(let name, let schema):
                return try "\(KW.ALTER) \(KW.COLLATION) \(name.sqlString()) \(KW.SET) \(KW.SCHEMA) \(schema.sqlString());"
            case .refreshVersion(let name):
                return try "\(KW.ALTER) \(KW.COLLATION) \(name.sqlString()) \(KW.REFRESH) \(KW.VERSION);"
            }
        }
    }

    private struct AlterCollationRefreshVersionIntermediate: AlterCollationRefreshVersion {
        let name: AnyName
        public func refreshVersion() -> AlterCollationStatement {
            return .refreshVersion(name)
        }
    }
}

public protocol AlterCollationRefreshVersion {
    func refreshVersion() -> PostgresStatement.AlterCollationStatement
}
