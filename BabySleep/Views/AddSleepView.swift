import SwiftUI

struct AddSleepView: View {

    @Environment(\.dismiss) private var dismiss

    @State private var startDate: Date = Date()
    @State private var endDate: Date = Date()
    @State private var wakeUps: Int = 0
    @State private var showPaywall = false

    private let storage = SleepStorageService()
    private let usageLimit = UsageLimitService()

    var body: some View {
        NavigationStack {

            VStack(spacing: 20) {

                VStack(alignment: .leading, spacing: 12) {
                    Text("Sleep started")
                        .font(.headline)

                    DatePicker(
                        "",
                        selection: $startDate,
                        displayedComponents: [.date, .hourAndMinute]
                    )
                    .datePickerStyle(.compact)
                    .labelsHidden()
                }

                Divider()

                VStack(alignment: .leading, spacing: 12) {
                    Text("Woke up")
                        .font(.headline)

                    DatePicker(
                        "",
                        selection: $endDate,
                        displayedComponents: [.date, .hourAndMinute]
                    )
                    .datePickerStyle(.compact)
                    .labelsHidden()
                }

                Divider()

                Stepper(
                    "Wake ups: \(wakeUps)",
                    value: $wakeUps,
                    in: 0...10
                )

                Text("\(usageLimit.remaining()) free nights left")
                    .foregroundColor(.secondary)

                Spacer()
            }
            .padding()
            .navigationTitle("Add Sleep")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {

                // Cancel
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }

                // CTA FIXO NO FUNDO (IGUAL HOME)
                ToolbarItem(placement: .bottomBar) {
                    Button(
                        usageLimit.canAddMore()
                        ? "Save Sleep"
                        : "Unlock full access"
                    ) {
                        onBottomButtonTapped()
                    }
                }
            }
            .sheet(isPresented: $showPaywall) {
                PaywallView()
            }
        }
    }

    // MARK: - Actions
    private func onBottomButtonTapped() {

        guard usageLimit.canAddMore() else {
            showPaywall = true
            return
        }

        let entry = SleepEntry(
            id: UUID(),
            startTime: startDate,
            endTime: endDate,
            wakeUps: wakeUps
        )

        storage.save(entry)
        usageLimit.increment()
        dismiss()
    }
}

#Preview {
    AddSleepView()
}
