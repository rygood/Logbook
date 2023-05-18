//
//  Entry+Test.swift
//  LogbookTests
//
//  Created by Ryan Goodlett on 5/18/23.
//

import Foundation

extension Entry: Testable {
    static let _testableName = "Testable Entry"
    static let _testableDate = Date.distantPast
    static let _testableLogbookId = "12345678"
    static let _testableNote = "Noted."

    static func testableMock() -> Entry {
        Entry(name: _testableName,
              date: _testableDate,
              logbookId: _testableLogbookId,
              note: _testableNote)
    }
}
