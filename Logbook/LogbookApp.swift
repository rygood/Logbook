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

	var database: Blackbird.Database

	init() {
		do {
			self.database = try Blackbird.Database(path: FileManager.dbPath(for: "logbook-dev.sqlite"),
												   options: [.debugPrintEveryQuery])
		} catch {
			fatalError("Unable to create database.")
		}
	}

    var body: some Scene {
        WindowGroup {
            MainView()
                .environment(\.blackbirdDatabase, database)
                .fontDesign(.rounded)
        }
    }
}
