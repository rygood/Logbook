//
//  EntryViewModel+Testable.swift
//  LogbookTests
//
//  Created by Ryan Goodlett on 5/18/23.
//

import Foundation

extension EntryViewModel: Testable {
    static let _testableName = "Testable EntryViewModel"
    static let _testableDate = Date.distantPast
    static let _testableLogbookId = "12345678"
    static let _testableNote = "Noted."

    static func testableMock() -> EntryViewModel {
        EntryViewModel(logbookId: _testableLogbookId,
                       date: _testableDate,
                       name: _testableName,
                       note: _testableNote)
    }
}
