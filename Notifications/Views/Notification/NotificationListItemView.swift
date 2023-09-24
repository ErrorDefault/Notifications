import SwiftUI

struct NotificationListItemView: View {
    @Bindable var notification: Notification
    var enableAction: (Notification) -> Void = { (notification: Notification) -> Void in }
    var disableAction: (Notification) -> Void = { (notification: Notification) -> Void in }
    
    var body: some View {
        HStack {
            Toggle(notification.title, isOn: $notification.enabled)
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
