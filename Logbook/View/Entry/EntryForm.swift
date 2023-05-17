//
//  EntryForm.swift
//  Logbook
//
//  Created by Ryan Goodlett on 5/17/23.
//

import SwiftUI

struct EntryForm: View {
    @FocusState private var focusedField: FocusedField?
    @Binding var entryViewModel: EntryViewModel

    var onSubmit: (() -> ())?

    enum FocusedField {
        case name
        case date
        case notes
    }

    var body: some View {
        Form {
            TextField("Name", text: $entryViewModel.name)
                .focused($focusedField, equals: .name)
                .onSubmit {
                    focusedField = .date
                }
            DatePicker("Date", selection: $entryViewModel.date)
                    .focused($focusedField, equals: .date)
                    .onSubmit {
                        focusedField = .notes
                    }
            TextField("Notes", text: $entryViewModel.note, axis: .vertical)
                .focused($focusedField, equals: .notes)
                .lineLimit(2...5)
        }
        .onAppear {
            focusedField = .name
        }
    }
}

struct EntryForm_Previews: PreviewProvider {
    static var previews: some View {
        EntryForm(entryViewModel: .constant(.mockPreview()))
    }
}
