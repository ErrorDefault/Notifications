//
//  NotificationsApp.swift
//  Notifications
//
//  Created by Justin Pham on 9/23/23.
//

import SwiftUI
import SwiftData

@main
struct NotificationsApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Notification.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(sharedModelContainer)
    }
}
