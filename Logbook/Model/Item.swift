//
//  Item.swift
//  Logbook
//
//  Created by Ryan Goodlett on 4/27/23.
//

import Blackbird

struct Item: BlackbirdModel {
    @BlackbirdColumn var id: Int
    @BlackbirdColumn var make: String
    @BlackbirdColumn var model: String
}
