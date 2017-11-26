/*
 *  ReservedHelper.swift
 *  Swiftgres
 *
 *  Copyright (c) 2018 David Piper, @_davidpiper
 *
 *  This software may be modified and distributed under the terms
 *  of the MIT license. See the LICENSE file for details.
 */

/**
    A helper for reserved tokens
 */
public struct ReservedHelper {
    public static let reservedKeywords = [
        "ALL",
        "ANALYSE",
        "ANALYZE",
        "AND",
        "ANY",
        "ARRAY",
        "AS",
        "ASC",
        "ASYMMETRIC",
        "BOTH",
        "CASE",
        "CAST",
        "CHECK",
        "COLLATE",
        "COLUMN",
        "CONSTRAINT",
        "CREATE",
        "CURRENT_CATALOG",
        "CURRENT_DATE",
        "CURRENT_ROLE",
        "CURRENT_TIME",
        "CURRENT_TIMESTAMP",
        "CURRENT_USER",
        "DEFAULT",
        "DEFERRABLE",
        "DESC",
        "DISTINCT",
        "DO",
        "ELSE",
        "END",
        "EXCEPT",
        "FALSE",
        "FETCH",
        "FOR",
        "FOREIGN",
        "FROM",
        "GRANT",
        "GROUP",
        "HAVING",
        "IN",
        "INITIALLY",
        "INTERSECT",
        "INTO",
        "LATERAL",
        "LEADING",
        "LIMIT",
        "LOCALTIME",
        "LOCALTIMESTAMP",
        "NOT",
        "NULL",
        "OFFSET",
        "ON",
        "ONLY",
        "OR",
        "ORDER",
        "PLACING",
        "PRIMARY",
        "REFERENCES",
        "RETURNING",
        "SELECT",
        "SESSION_USER",
        "SOME",
        "SYMMETRIC",
        "TABLE",
        "THEN",
        "TO",
        "TRAILING",
        "TRUE",
        "UNION",
        "UNIQUE",
        "USER",
        "USING",
        "VARIADIC",
        "WHEN",
        "WHERE",
        "WINDOW",
        "WITH"
    ]
    
    // Case-insensitive check whether the given string is a reserved keyword
    public static func isReserved(keyword: String) -> Bool {
        return reservedKeywords.contains(keyword.uppercased())
    }
}
