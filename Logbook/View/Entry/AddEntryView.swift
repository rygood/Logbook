//
//  AddEntryView.swift
//  Logbook
//
//  Created by Ryan Goodlett on 4/28/23.
//

import SwiftUI

struct AddEntryView: View {
    @Environment(\.blackbirdDatabase) var db
    @Environment(\.dismiss) var dismiss

    @FocusState private var isNameFieldFocused: Bool
	@State var logbookId: String?
	// TODO: Don't allow for empty names
    @State var entryViewModel = EntryViewModel()

    
    var body: some View {
        NavigationStack {
            EntryForm(entryViewModel: $entryViewModel)
            .navigationTitle("New Entry")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button(action: {
                        dismiss()
                    }) {
                        Text("Cancel")
                    }
                }

                ToolbarItem(placement: .confirmationAction) {
                    Button(action: {
                        Task { await addItem() }
                    }) {
                        Text("Add")
                    }
                }
            }
        }
    }

    private func addItem() async {
        guard let db,
		let logbookId else { return }

        let entry = Entry.now(logbookId, entryViewModel: entryViewModel)
        try! await entry.write(to: db)
        dismiss()
    }
}

