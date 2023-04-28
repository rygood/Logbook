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

    private init(id: String, creationDate: Date, modifiedDate: Date, name: String) {
        self.id = id
        self.creationDate = creationDate
        self.modifiedDate = modifiedDate
        self.name = name
    }

    init(name: String) {
        self.init(id: UUID().uuidString,
             creationDate: Date.now,
             modifiedDate: Date.now,
             name: name
        )
    }
}
