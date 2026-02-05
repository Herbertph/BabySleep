import SwiftUI

struct RootView: View {

    @State private var profile: BabyProfile?

    private let storage = BabyProfileStorage()

    var body: some View {
        Group {
            if let profile = profile {
                HomeView(profile: profile)
            } else {
                OnboardingView(onFinish: {
                    loadProfile()
                })
            }
        }
        .onAppear {
            loadProfile()
        }
    }

    private func loadProfile() {
        profile = storage.load()
    }
}

#Preview {
    RootView()
}
