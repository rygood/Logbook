//
//  Entry.swift
//  Logbook
//
//  Created by Ryan Goodlett on 4/27/23.
//

import Foundation
import Blackbird

struct Entry: BlackbirdModel {
    @BlackbirdColumn var id: Int
    @BlackbirdColumn var logbook_id: Int
    @BlackbirdColumn var date: Date
    @BlackbirdColumn var name: String
    @BlackbirdColumn var note: String?
}
