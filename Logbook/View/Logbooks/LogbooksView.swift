//
//  LogbooksView.swift
//  Logbook
//
//  Created by Ryan Goodlett on 4/27/23.
//

import SwiftUI
import Blackbird

struct LogbooksView: View {
    @Environment(\.blackbirdDatabase) var db
    
    @BlackbirdLiveModels({ try await Logbook.read(from: $0, orderBy: .ascending(\.$name)) }) var logbooks

    @State private var showAddLogbookView = false

    var body: some View {
        NavigationView {
            List {
                if logbooks.didLoad && !logbooks.results.isEmpty {
                    ForEach(logbooks.results) { logbook in
                        NavigationLink {
                            Text(logbook.name)
                        } label: {
                            Text(logbook.name)
                        }
                    }
                    .onDelete(perform: { indexSet in
                        Task {
                            await deleteItems(offsets: indexSet)
                        }
                    })
                } else {
                    Text("No Logbooks")
                }
            }
            .toolbar {
#if os(iOS)
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
#endif
                ToolbarItem {
                    Button(action: {
                        showAddLogbookView.toggle()
                    }) {
                        Label("Add Logbook", systemImage: "plus")
                    }
                    .sheet(isPresented: $showAddLogbookView) {
                        AddLogbookView()
                    }
                }

                ToolbarItem(placement: .navigationBarLeading) {
                    Text("Logbooks")
                        .font(.title)
                        .fontWeight(.heavy)
                }
            }
        }
    }

    private func deleteItems(offsets: IndexSet) async {
        guard let db else { return }

        _ = await offsets.asyncMap { offset in
            let logbook = logbooks.results[offset]
            try! await logbook.delete(from: db)
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct LogbooksView_Previews: PreviewProvider {
    static var previews: some View {
        LogbooksView()
            .fontDesign(.rounded)
    }
}

extension Sequence {
    func asyncMap<T>(_ transform: @escaping (Element) async -> T) async -> [T] {
        return await withTaskGroup(of: T.self) { group in
            var transformedElements = [T]()

            for element in self {
                group.addTask {
                    return await transform(element)
                }
            }

            for await transformedElement in group {
                transformedElements.append(transformedElement)
            }

            return transformedElements
        }
    }
}
