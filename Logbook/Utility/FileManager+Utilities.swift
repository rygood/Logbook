//
//  FileManager+Utilities.swift
//  Logbook
//
//  Created by Ryan Goodlett on 4/28/23.
//

import Foundation

extension FileManager {
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

	static func dbPath(for file: String) throws -> String {
		guard let pathForAppSupportDirectory = FileManager
			.pathForAppSupportDirectoryAsUrl()?
			.path(percentEncoded: false)
		else {
			throw DBError.getAppSupportDirectoryPath
		}

		return pathForAppSupportDirectory.appending(file)
	}

	private static func checkAndCreateDirectory(at path: String) throws {
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
