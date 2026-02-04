import SwiftUI

struct HomeView: View {

    let profile: BabyProfile

    var body: some View {
        VStack(spacing: 16) {

            Spacer()

            Text("Welcome")
                .font(.largeTitle)
                .fontWeight(.bold)

            if let name = profile.name, !name.isEmpty {
                Text("How is \(name)'s sleep today?")
            } else {
                Text("How is your baby's sleep today?")
            }

            Text("Age: \(profile.ageInMonths) months")
                .foregroundColor(.secondary)

            Spacer()
        }
        .padding()
    }
}

#Preview {
    HomeView(profile: BabyProfile(name: "Alex", ageInMonths: 6))
}
