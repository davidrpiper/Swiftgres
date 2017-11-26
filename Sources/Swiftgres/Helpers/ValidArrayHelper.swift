/*
 *  ValidArrayHelper.swift
 *  Swiftgres
 *
 *  Copyright (c) 2018 David Piper, @_davidpiper
 *
 *  This software may be modified and distributed under the terms
 *  of the MIT license. See the LICENSE file for details.
 */

public struct ValidArrayHelper {
    /**
        Returns true if the array has at least one element and every element
        in the array isValid().
    */
    public static func isValidAndNotEmpty(_ arr: Array<PostgresGrammarType>) -> Bool {
        return arr.count > 0 && isValid(arr)
    }
    
    /**
        Returns true if every element in the array isValid(). Will also return
        true for empty arrays. Returns false if the array contains at least
        one element that is not valid.
    */
    public static func isValid(_ arr: Array<PostgresGrammarType>) -> Bool {
        return !arr.contains(where: { !$0.isValid() })
    }
}
