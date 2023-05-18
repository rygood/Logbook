//
//  Previewable.swift
//  Logbook
//
//  Created by Ryan Goodlett on 5/17/23.
//

import Foundation


protocol Previewable {
    /// The type to be mocked
    associatedtype MockType
    /// Generates a mock of type `MockType` for Previews
    static func previewableMock() -> MockType
}
