//
//  Entry.swift
//  Logbook
//
//  Created by Ryan Goodlett on 4/27/23.
//

import Foundation
import Blackbird

struct Entry: BlackbirdModel {
    @BlackbirdColumn var id: String
    @BlackbirdColumn var logbookId: String
    @BlackbirdColumn var date: Date
    @BlackbirdColumn var name: String
    @BlackbirdColumn var note: String?

    init(name: String, date: Date, logbookId: String, note: String?) {
		self.name = name
		self.logbookId = logbookId
		self.note = note
		self.id = UUID().uuidString
		self.date = date
	}

    /// Creates an Entry from the `logBookId` and `EntryViewModel` with a Date of `.now`
    static func now(_ logbookId: String, entryViewModel: EntryViewModel) -> Entry {
        return Entry(name: entryViewModel.name,
                     date: .now,
                     logbookId: logbookId,
                     note: entryViewModel.note)
    }

    mutating func update(from viewModel: EntryViewModel) {
        self.logbookId = viewModel.logbookId
        self.date = viewModel.date
        self.name = viewModel.name
        self.note = viewModel.note
    }
}

extension Entry: Previewable {
    static let _previewableName = "Previewable Entry"
    static let _previewableDate = Date.distantPast
    static let _previewableLogbookId = "12345678"
    static let _previewableNote = "Noted."

    static func previewableMock() -> Entry {
        Entry(name: _previewableName,
              date: _previewableDate,
              logbookId: _previewableLogbookId,
              note: _previewableNote
        )
    }
}
