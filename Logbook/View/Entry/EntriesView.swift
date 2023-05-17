//
//  EntriesView.swift
//  Logbook
//
//  Created by Ryan Goodlett on 4/28/23.
//

import SwiftUI
import Blackbird

struct EntriesView: View {
	@Environment(\.blackbirdDatabase) var db

	@BlackbirdLiveModel var logbook: Logbook?

	@State var entries = Entry.LiveResults()
	@State private var showAddEntryView = false

	var entriesUpdater = Entry.ArrayUpdater()

    var body: some View {
			Group {
				if entries.didLoad {
                    List {
                        if !entries.results.isEmpty {
                            ForEach(entries.results) { entry in
                                NavigationLink(destination: {
                                    EntryView(entry: entry)
                                }, label: {
                                    Text(entry.name)
                                })
                            }
                            .onDelete(perform: { indexSet in
                                Task {
                                    await deleteItems(offsets: indexSet)
                                }
                            })
                        } else {
                            Text("No Entries")
                        }
                    }
				} else {
					ProgressView()
				}
			}
			.onAppear {
				entriesUpdater.bind(from: db, to: $entries) {
					try await Entry.read(from: $0,
										 matching: \.$logbookId == logbook?.$id.wrappedValue,
										 orderBy: .ascending(\.$date)) }
			}
			.toolbar {
#if os(iOS)
				ToolbarItem(placement: .navigationBarTrailing) {
					EditButton()
				}
#endif
				ToolbarItem {
					Button(action: {
						showAddEntryView.toggle()
					}) {
						Label("Add Entry", systemImage: "plus")
					}
					.sheet(isPresented: $showAddEntryView) {
						AddEntryView(logbookId: logbook?.$id.wrappedValue)
					}
				}
			}
			.navigationTitle("Entries")
    }

	private func deleteItems(offsets: IndexSet) async {
		guard let db else { return }

		_ = await offsets.asyncMap { offset in
			let entry = entries.results[offset]
			try! await entry.delete(from: db)
		}
	}
}

struct EntriesView_Previews: PreviewProvider {
	static var logbook = Logbook(name: "Test")
    static var previews: some View {
		EntriesView(logbook: BlackbirdLiveModel(logbook))
    }
}
