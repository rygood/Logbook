//
//  AddLogbookView.swift
//  Logbook
//
//  Created by Ryan Goodlett on 4/28/23.
//

import SwiftUI

struct AddLogbookView: View {
    @Environment(\.blackbirdDatabase) var db
    @Environment(\.dismiss) var dismiss

    @FocusState private var isNameFieldFocused: Bool
    @State var name: String = ""

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
            .navigationTitle("New Logbook")
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
        guard let db else { return }

        let logbook = Logbook(name: name)
        try! await logbook.write(to: db)
        dismiss()
    }
}

struct AddLogbookView_Previews: PreviewProvider {
    static var previews: some View {
        AddLogbookView()
    }
}
