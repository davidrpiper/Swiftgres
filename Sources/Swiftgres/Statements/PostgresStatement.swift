/*
 *  PostgresStatement.swift
 *  Swiftgres
 *
 *  Copyright (c) 2018 David Piper, @_davidpiper
 *
 *  This software may be modified and distributed under the terms
 *  of the MIT license. See the LICENSE file for details.
 */

public struct PostgresStatement { }

public protocol CommitablePostgresStatement {
    func toSql() throws -> String
}
