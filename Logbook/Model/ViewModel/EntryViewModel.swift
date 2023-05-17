//
//  EntryViewModel.swift
//  Logbook
//
//  Created by Ryan Goodlett on 5/2/23.
//

import SwiftUI
import Blackbird

struct EntryViewModel {

	var logbookId: String = ""
    var date: Date = Date.distantPast
	var name: String = ""
	var note: String = ""

    mutating func update(from entry: Entry) {
        self.logbookId = entry.logbookId
        self.date = entry.date
        self.name = entry.name
        self.note = entry.note ?? ""
    }
}

extension EntryViewModel: Equatable {
    static func == (lhs: EntryViewModel, rhs: EntryViewModel) -> Bool {
        lhs.logbookId == rhs.logbookId &&
        lhs.name == rhs.name &&
        lhs.date == rhs.date &&
        lhs.note == rhs.note
    }

}
