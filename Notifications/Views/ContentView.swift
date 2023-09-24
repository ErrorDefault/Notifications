//
//  ContentView.swift
//  Notifications
//
//  Created by Justin Pham on 9/23/23.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Notification]

    var body: some View {
        NavigationSplitView {
            List {
                ForEach(items) { item in
                    NavigationLink {
                        NotificationDetailsView(
                            notification: item,
                            enableAction: enableNotificationAction,
                            disableAction: disableNotificationAction
                        )
                    } label: {
                        NotificationListItemView(
                            notification: item,
                            enableAction: enableNotificationAction,
                            disableAction: disableNotificationAction
                        )
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button(action: addItem) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
        } detail: {
            Text("Select an item")
        }
    }

    private func addItem() {
        withAnimation {
            let newItem = Notification(title: "Save Water", body: "Turn off the tap!", hour: 8)
            modelContext.insert(newItem)
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                disableNotificationAction(notification: items[index])
                modelContext.delete(items[index])
            }
        }
    }
    
    private func enableNotificationAction(notification: Notification) {
        // Create Content
        let content = UNMutableNotificationContent()
        content.title = notification.title
        content.body = notification.body
        
        // Configure the recurring date.
        var dateComponents = DateComponents()
        dateComponents.calendar = Calendar.current

        dateComponents.hour = notification.hour
        dateComponents.minute = notification.minute
           
        // Create the trigger as a repeating event.
        let trigger = UNCalendarNotificationTrigger(
                 dateMatching: dateComponents, repeats: true)
        
        // Create the request
        let uuidString = notification.id.uuidString
        let request = UNNotificationRequest(identifier: uuidString,
                                            content: content, trigger: trigger)

        // Schedule the request with the system.
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.add(request) { (error) in
           if error != nil {
              // Handle any errors.
           }
        }
    }
    
    private func disableNotificationAction(notification: Notification) {
        // Disable the request with the system.
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.removePendingNotificationRequests(withIdentifiers: [notification.id.uuidString])
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Notification.self, inMemory: true)
}
