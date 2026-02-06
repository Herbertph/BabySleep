import SwiftUI

struct PaywallView: View {

    var body: some View {
        VStack(spacing: 24) {

            Spacer()

            Text("Unlock Soninho")
                .font(.largeTitle)
                .fontWeight(.bold)

            Text("Track your baby’s sleep without limits and gain peace of mind.")
                .multilineTextAlignment(.center)
                .foregroundColor(.secondary)

            VStack(spacing: 12) {
                Label("Unlimited sleep tracking", systemImage: "checkmark.circle")
                Label("Age-based comparison", systemImage: "checkmark.circle")
                Label("Calm, judgment-free insights", systemImage: "checkmark.circle")
            }

            Button(action: {
                // StoreKit entra depois
            }) {
                Text("Start for $4.99")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.primaryBlue)
                    .foregroundColor(.white)
                    .cornerRadius(16)
            }

            Text("One-time purchase. No subscription.")
                .font(.footnote)
                .foregroundColor(.secondary)

            Spacer()
        }
        .padding()
    }
}

#Preview {
    PaywallView()
}
