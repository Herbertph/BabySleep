import Foundation

struct SleepEntry: Codable, Identifiable {
    let id: UUID
    let startTime: Date
    let endTime: Date
    let wakeUps: Int

    var totalSleepHours: Double {
        let interval = endTime.timeIntervalSince(startTime)
        return interval / 3600
    }
}

