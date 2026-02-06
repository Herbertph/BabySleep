import SwiftUI

struct SleepComparisonView: View {

    let sleepEntry: SleepEntry
    let babyAge: Int

    private let rangeService = SleepRangeService()

    var body: some View {
        VStack(spacing: 16) {

            Text("Sleep Comparison")
                .font(.headline)
                .foregroundColor(Color.primaryBlue)

            if let range = rangeService.range(for: babyAge) {

                Text("Your baby slept \(sleepEntry.formattedDuration)")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundColor(.primary)

                Text("Expected range for this age:")
                    .foregroundColor(.secondary)

                Text("\(Int(range.min))h – \(Int(range.max))h")
                    .font(.body)
                    .foregroundColor(.primary)

                Divider()

                // FRASE EMPÁTICA (AGORA VISÍVEL)
                Text(feedbackMessage(
                    for: sleepEntry.totalSleepInterval / 3600,
                    range: range
                ))
                .font(.body)
                .foregroundColor(.primary)
                .multilineTextAlignment(.center)

            } else {
                Text("No comparison data available.")
                    .foregroundColor(.secondary)
            }
        }
        .padding()
        .background(Color.cardBackground)
        .cornerRadius(16)
    }

    private func feedbackMessage(for hours: Double, range: SleepRange) -> String {
        if hours < range.min {
            return "This is below the average range, and that can be exhausting. Many babies go through phases like this — you are not doing anything wrong."
        } else if hours > range.max {
            return "Your baby slept more than average. Enjoy it — this is completely normal at this age."
        } else {
            return "This amount of sleep is well within the normal range for this age. Your baby’s sleep looks healthy."
        }
    }
}

#Preview {
    SleepComparisonView(
        sleepEntry: SleepEntry(
            id: UUID(),
            startTime: Date().addingTimeInterval(-8 * 3600),
            endTime: Date(),
            wakeUps: 2
        ),
        babyAge: 13
    )
}
