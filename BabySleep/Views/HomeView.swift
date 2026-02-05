import SwiftUI

struct HomeView: View {

    let profile: BabyProfile

    @State private var showAddSleep = false
    @State private var lastSleep: SleepEntry?

    private let sleepStorage = SleepStorageService()

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {

                Text("Welcome")
                    .font(.largeTitle)
                    .fontWeight(.bold)

                if let name = profile.name {
                    Text("How is \(name)'s sleep?")
                } else {
                    Text("How is your baby's sleep?")
                }

                Text("Age: \(profile.ageInMonths) months")
                    .foregroundColor(.secondary)

                Divider()

                if let sleep = lastSleep {

                    Text("Last sleep")
                        .font(.headline)

                    Text(String(format: "%.1f hours", sleep.totalSleepHours))
                        .font(.title2)
                        .fontWeight(.semibold)

                    Text("Wake ups: \(sleep.wakeUps)")
                        .foregroundColor(.secondary)

                    SleepComparisonView(
                        sleepEntry: sleep,
                        babyAge: profile.ageInMonths
                    )

                } else {
                    Text("No sleep data yet.")
                        .foregroundColor(.secondary)
                }

                Spacer()

                Button(action: {
                    showAddSleep = true
                }) {
                    Text("Add Sleep")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }
            }
            .padding()
            .onAppear {
                loadLastSleep()
            }
            .sheet(isPresented: $showAddSleep, onDismiss: {
                loadLastSleep()
            }) {
                AddSleepView()
            }
        }
    }

    private func loadLastSleep() {
        lastSleep = sleepStorage.lastEntry()
    }
}

#Preview {
    HomeView(profile: BabyProfile(name: "Alex", ageInMonths: 6))
}
