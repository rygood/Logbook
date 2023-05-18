//
//  Testable.swift
//  LogbookTests
//
//  Created by Ryan Goodlett on 5/18/23.
//

import Foundation

protocol Testable {
    /// The type to be mocked
    associatedtype MockType
    /// Generates a mock of type `MockType` for testing
    static func testableMock() -> MockType
}
