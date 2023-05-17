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

	init(name: String, logbookId: String, note: String?) {
		self.name = name
		self.logbookId = logbookId
		self.note = note
		self.id = UUID().uuidString
		self.date = Date.now
	}

    mutating func update(from viewModel: EntryViewModel) {
        self.logbookId = viewModel.logbookId
        self.date = viewModel.date
        self.name = viewModel.name
        self.note = viewModel.note
    }
}
