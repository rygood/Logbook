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
                if logbooks.didLoad {
                    List {
                        if !logbooks.results.isEmpty {
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
                    }
                } else {
                    ProgressView()
                }
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

    private func addItem() {
        withAnimation {
            
        }
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
