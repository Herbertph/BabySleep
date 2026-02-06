import Foundation

struct SleepEntry: Codable, Identifiable {
    let id: UUID
    let startTime: Date
    let endTime: Date
    let wakeUps: Int

    var totalSleepInterval: TimeInterval {
        endTime.timeIntervalSince(startTime)
    }

    var formattedDuration: String {
        let totalMinutes = Int(totalSleepInterval / 60)
        let hours = totalMinutes / 60
        let minutes = totalMinutes % 60
        return "\(hours)h \(String(format: "%02d", minutes))min"
    }
}
