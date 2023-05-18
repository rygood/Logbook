//
//  Logbook+Testable.swift
//  LogbookTests
//
//  Created by Ryan Goodlett on 5/18/23.
//

import Foundation

extension Logbook: Testable {
    static let _testableName = "Testable Logbook"

    static func testableMock() -> Logbook {
        Logbook(name: _testableName)
    }
}
