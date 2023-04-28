//
//  MainView.swift
//  Logbook
//
//  Created by Ryan Goodlett on 3/27/23.
//

import SwiftUI
import Blackbird

struct MainView: View {

    var body: some View {
        TabView {
            UpcomingView()
                .tabItem {
                    Label("Upcoming", systemImage: "hourglass")
                }

            LogbooksView()
                .tabItem {
                    Label("Logbooks", systemImage: "text.book.closed")
                }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
