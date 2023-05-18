//
//  EntryView.swift
//  Logbook
//
//  Created by Ryan Goodlett on 5/2/23.
//

import SwiftUI
import Blackbird

// TODO: - View Data Sync Issue
// There is currently an issue where if 2 instances of the app are open
// and one updates an Entry, the other won't update until the view is reloaded.
struct EntryView: View {
	@Environment(\.blackbirdDatabase) var db
    @State var didLoad = false
	@State var entry: Entry?
    @State var entryViewModel = EntryViewModel()
	var entryUpdater = Entry.InstanceUpdater()

    var body: some View {
        Group {
            if didLoad {
                EntryForm(entryViewModel: $entryViewModel)
            } else {
                ProgressView()
            }
		}
		.onAppear {
            if let entry {
                entryViewModel.update(from: entry)
                entryUpdater.bind(from: db,
                                  to: $entry,
                                  didLoad: $didLoad,
                                  id: entry.id)
            }
		}
        .onChange(of: entryViewModel) { newValue in
            guard let db else { return }
            Task {
                entry?.update(from: newValue)
                try await entry?.write(to: db)
            }
        }
    }
}

struct EntryView_Previews: PreviewProvider {
    static var previews: some View {
        EntryView(entry: .previewableMock())
    }
}
