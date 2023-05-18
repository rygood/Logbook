//
//  Logbook.swift
//  Logbook
//
//  Created by Ryan Goodlett on 4/27/23.
//

import Foundation
import Blackbird

struct Logbook: BlackbirdModel {
    @BlackbirdColumn var id: String
    @BlackbirdColumn var creationDate: Date
    @BlackbirdColumn var modifiedDate: Date
    @BlackbirdColumn var name: String

    init(name: String) {
		self.id = UUID().uuidString
		self.creationDate = Date.now
		self.modifiedDate = Date.now
		self.name = name
    }
}

extension Logbook: Previewable {
    static let _previewableName = "Previewable Logbook"

    static func previewableMock() -> Logbook {
        Logbook(name: _previewableName)
    }
}
