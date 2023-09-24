import Foundation
import SwiftData

@Model
final class Notification: Identifiable {
    var id: UUID
    var enabled: Bool
    var title: String
    var body: String
    var hour: Int
    var minute: Int
    
    init(title: String, body: String, hour: Int, minute: Int = 0) {
        self.id = UUID()
        self.enabled = false
        self.title = title
        self.body = body
        self.hour = hour
        self.minute = minute
    }
    
    func formatTime(uses24HourTimeFormat: Bool = false) -> String {
        let minuteF = String(format: "%02d", minute)
        if (uses24HourTimeFormat) {
            return "\(String(format: "%02d", hour)):\(minuteF)"
        } else {
            if (hour == 0) {
                return "12:\(minuteF) AM"
            }
            else if (1 <= hour && hour <= 11) {
                return "\(hour):\(minuteF) AM"
            }
            else if (hour == 12) {
                return "12:\(minuteF) PM"
            }
            else {
                return "\(hour-12):\(minuteF) PM"
            }
        }
    }
}
