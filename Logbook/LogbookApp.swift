//
//  LogbookApp.swift
//  Logbook
//
//  Created by Ryan Goodlett on 3/27/23.
//

import SwiftUI
import Blackbird

@main
struct LogbookApp: App {

    var database = try! Blackbird.Database(path: Bundle.main.url(forResource: "Logbooks_Test", withExtension: "sqlite3")!.absoluteString, options: [.debugPrintEveryQuery])

    var body: some Scene {
        WindowGroup {
            MainView()
                .environment(\.blackbirdDatabase, database)
                .fontDesign(.rounded)
        }
    }
}
