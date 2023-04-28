//
//  UpcomingView.swift
//  Logbook
//
//  Created by Ryan Goodlett on 3/27/23.
//

import SwiftUI
import Blackbird

struct UpcomingView: View {
    @BlackbirdLiveModels({ try await Logbook.read(from: $0, orderBy: .ascending(\.$id)) }) var logbooks

    var body: some View {
        NavigationView {
            List {
                if logbooks.didLoad && !logbooks.results.isEmpty {
                    ForEach(logbooks.results) { logbook in
                        NavigationLink {
                            Text("Item at \(logbook.creationDate, formatter: itemFormatter)")
                        } label: {
                            Text(logbook.creationDate, formatter: itemFormatter)
                        }
                    }
                } else {
                    Text("No Logbooks")
                }
//                .onDelete(perform: deleteItems)
            }
            .toolbar {
#if os(iOS)
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
#endif
                ToolbarItem {
                    Button(action: addItem) {
                        Label("Add Item", systemImage: "plus")
                    }
                }

                ToolbarItem(placement: .navigationBarLeading) {
                    Text("Upcoming")
                        .font(.title)
                        .fontWeight(.heavy)
                }
            }
        }
    }

    private func addItem() {
        withAnimation {
            
        }
    }

    private func deleteItems(offsets: IndexSet) {
//        withAnimation {
//            offsets.map { logbooks[$0] }.forEach(viewContext.delete)
//
//            do {
//                try viewContext.save()
//            } catch {
//                // Replace this implementation with code to handle the error appropriately.
//                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//                let nsError = error as NSError
//                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//            }
//        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct UpcomingView_Previews: PreviewProvider {
    static var previews: some View {
        UpcomingView()
            .fontDesign(.rounded)
    }
}
