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
}
