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
    
    @BlackbirdLiveModels({ try await Logbook.read(from: $0, orderBy: .ascending(\.$creationDate)) }) var logbooks

    var body: some View {
        NavigationView {
            List {
                if logbooks.didLoad && !logbooks.results.isEmpty {
                    ForEach(logbooks.results) { logbook in
                        NavigationLink {
                            Text("\(logbook.name) at \(logbook.creationDate, formatter: itemFormatter)")
                        } label: {
                            Text("\(logbook.name) - \(logbook.creationDate, formatter: itemFormatter)")
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
                        Task { await addItem() }
                    }) {
                        Label("Add Logbook", systemImage: "plus")
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

    private func addItem() async {
        guard let db else { return }

        let logbook = Logbook(name: UUID().uuidString)
        try! await logbook.write(to: db)
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
