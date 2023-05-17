//
//  MainView.swift
//  Logbook
//
//  Created by Ryan Goodlett on 3/27/23.
//

import SwiftUI
import Blackbird

struct MainView: View {
    @State var selectedTabIndex: TabIndex = .logbooks

    enum TabIndex: Int {
        case upcoming
        case logbooks
    }

    var body: some View {
        TabView(selection: $selectedTabIndex) {
            UpcomingView()
                .tabItem {
                    Label("Upcoming", systemImage: "hourglass")
                }.tag(TabIndex.upcoming)

            LogbooksView()
                .tabItem {
                    Label("Logbooks", systemImage: "text.book.closed")
                }.tag(TabIndex.logbooks)
        }
    }
}


struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
