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
    @State var name: String = ""
	@State var note: String?

    var body: some View {
        NavigationStack {
            List {
                TextField("Name", text: $name)
                    .focused($isNameFieldFocused)
                    .onSubmit {
                        isNameFieldFocused.toggle()
                        Task { await addItem() }
                    }
                    .onAppear {
                        isNameFieldFocused = true
                    }
            }
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

        let entry = Entry(name: name,
							logbookId: logbookId,
							note: note)
        try! await entry.write(to: db)
        dismiss()
    }
}

