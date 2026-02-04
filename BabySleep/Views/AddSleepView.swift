import SwiftUI

struct AddSleepView: View {

    @Environment(\.dismiss) private var dismiss

    @State private var startTime: Date = Date().addingTimeInterval(-8 * 3600)
    @State private var endTime: Date = Date()
    @State private var wakeUps: Int = 0

    private let storage = SleepStorageService()

    var body: some View {
        VStack(spacing: 24) {

            Text("Add Sleep")
                .font(.largeTitle)
                .fontWeight(.bold)

            DatePicker("Sleep start", selection: $startTime, displayedComponents: .hourAndMinute)
            DatePicker("Wake up", selection: $endTime, displayedComponents: .hourAndMinute)

            Stepper("Wake ups: \(wakeUps)", value: $wakeUps, in: 0...10)

            Button(action: {
                let entry = SleepEntry(
                    id: UUID(),
                    startTime: startTime,
                    endTime: endTime,
                    wakeUps: wakeUps
                )

                storage.save(entry)
                dismiss()
            }) {
                Text("Save")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(12)
            }

            Spacer()
        }
        .padding()
    }
}

#Preview {
    AddSleepView()
}
