import SwiftUI

struct OnboardingView: View {

    @State private var babyName: String = ""
    @State private var ageInMonths: Int = 3
    @State private var navigateToHome: Bool = false
    @State private var savedProfile: BabyProfile?

    private let storage = BabyProfileStorage()

    var body: some View {
        NavigationStack {
            VStack(spacing: 24) {

                Spacer()

                Text("Baby Sleep")
                    .font(.largeTitle)
                    .fontWeight(.bold)

                Text("Discover if your baby’s sleep is normal.")
                    .font(.body)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.secondary)

                VStack(alignment: .leading, spacing: 16) {

                    TextField("Baby's name (optional)", text: $babyName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())

                    VStack(alignment: .leading, spacing: 8) {
                        Text("Age in months: \(ageInMonths)")
                            .font(.subheadline)

                        Stepper("", value: $ageInMonths, in: 0...24)
                    }
                }

                Button(action: {
                    let profile = BabyProfile(
                        name: babyName.isEmpty ? nil : babyName,
                        ageInMonths: ageInMonths
                    )

                    storage.save(profile)
                    savedProfile = profile
                    navigateToHome = true
                }) {
                    Text("Continue")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }

                Spacer()
            }
            .padding()
            .navigationDestination(isPresented: $navigateToHome) {
                if let profile = savedProfile {
                    HomeView(profile: profile)
                }
            }
        }
    }
}

#Preview {
    OnboardingView()
}
