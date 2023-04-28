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

    var database = try! Blackbird.Database(path: dbPath(), options: [.debugPrintEveryQuery])

    var body: some Scene {
        WindowGroup {
            MainView()
                .environment(\.blackbirdDatabase, database)
                .fontDesign(.rounded)
        }
    }

    static func dbPath() throws -> String {
        guard let pathForAppSupportDirectory = pathForAppSupportDirectoryAsUrl()?.path(percentEncoded: false) else { throw DBError.getAppSupportDirectoryPath }

        return pathForAppSupportDirectory.appending("logbook-dev.sqlite")
    }

    static func pathForAppSupportDirectoryAsUrl() -> URL? {
        var appSupportDirectory: URL?
        do {
            appSupportDirectory = try FileManager.default.url(for: .applicationSupportDirectory,
                                                              in: .userDomainMask,
                                                              appropriateFor: nil,
                                                              create: true)
        } catch {
            print(error)
        }

        return appSupportDirectory
    }

    static func checkAndCreateDirectory(at path: String) throws {
        let fm = FileManager.default
        if !fm.fileExists(atPath: path) {
            do {
                try fm.createDirectory(atPath: path,
                                       withIntermediateDirectories: false,
                                       attributes: nil)
            } catch {
                throw DBError.createAppSupportDirectory
            }
        }
    }
}
