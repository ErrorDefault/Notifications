//
//  NotificationDetailsView.swift
//  Notifications
//
//  Created by Justin Pham on 9/24/23.
//

import SwiftUI

struct NotificationDetailsView: View {
    @Bindable var notification: Notification
    var enableAction: (Notification) -> Void = { (notification: Notification) -> Void in }
    var disableAction: (Notification) -> Void = { (notification: Notification) -> Void in }
    
    var body: some View {
        VStack {
            Text(notification.title)
                .font(.title)
            Text(notification.body)
            Text(notification.formatTime())
            Toggle("Enabled", isOn: $notification.enabled)
                .onChange(of: notification.enabled) {
                    if(notification.enabled) {
                        enableAction(notification)
                    } else {
                        disableAction(notification)
                    }
                }
        }
    }
}

let _notification = Notification(title: "Save Water", body: "Turn off the tap!", hour: 8)

#Preview {
    NotificationDetailsView(notification: _notification)
}
