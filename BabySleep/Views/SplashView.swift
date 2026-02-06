import SwiftUI

struct SplashView: View {

    @State private var isActive = false

    var body: some View {
        if isActive {
            RootView()
        } else {
            VStack {
                Spacer()

                Image("SoninhoLogo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 180)

                Spacer()
            }
            .background(Color.white)
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    withAnimation {
                        isActive = true
                    }
                }
            }
        }
    }
}

#Preview {
    SplashView()
}
