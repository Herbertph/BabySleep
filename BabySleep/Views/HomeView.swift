import SwiftUI

struct HomeView: View {

    let profile: BabyProfile

    @State private var showAddSleep = false
    @State private var lastSleep: SleepEntry?

    private let sleepStorage = SleepStorageService()

    var body: some View {

        ScrollView {
            VStack(spacing: 20) {

                Text("How is \(profile.name ?? "your baby's") sleep?")
                    .font(.title2)
                    .fontWeight(.semibold)

                Text("Age: \(profile.ageInMonths) months")
                    .foregroundColor(.secondary)

                Divider()

                if let sleep = lastSleep {

                    Text("Last sleep")
                        .font(.headline)

                    Text(sleep.formattedDuration)
                        .font(.largeTitle)
                        .fontWeight(.bold)

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

                // BOTÃO VISÍVEL DENTRO DA TELA
                Button(action: {
                    showAddSleep = true
                }) {
                    Text("Add Sleep")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.primaryBlue)
                        .foregroundColor(.white)
                        .cornerRadius(14)
                }
                .padding(.top, 24)

                Spacer(minLength: 40)
            }
            .padding()
        }
        .navigationTitle("Welcome")
        .toolbar {
            // BOTÃO SIMPLES (Apple-style)
            ToolbarItem(placement: .bottomBar) {
                Button("Add Sleep") {
                    showAddSleep = true
                }
            }
        }
        .onAppear {
            loadLastSleep()
        }
        .sheet(isPresented: $showAddSleep, onDismiss: {
            loadLastSleep()
        }) {
            AddSleepView()
        }
    }

    private func loadLastSleep() {
        lastSleep = sleepStorage.lastEntry()
    }
}

#Preview {
    HomeView(profile: BabyProfile(name: "Lilly", ageInMonths: 13))
}
