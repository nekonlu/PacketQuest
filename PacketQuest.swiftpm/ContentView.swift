import SwiftUI

struct ContentView: View {

    @State private var isLandscape: Bool = false

    var body: some View {
        NavigationStack {
            VStack(spacing: 48) {
                VStack(spacing: 24) {
                    Image(systemName: "network")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 128, height: 128)
                        .foregroundStyle(.black)
                    VStack(spacing: 16) {
                        Text("Packet Quest")
                            .font(.title)
                            .fontWeight(.bold)
                        Text("You can learn simple L3 networking.")
                    }

                }
                
                NavigationLink {
                    Stage1_1_GameView()
                } label: {
                    Text("Let's begin!")
                        .fontWeight(.bold)
                        .padding()
                        .foregroundStyle(.white)
                        .background {
                            RoundedRectangle(cornerRadius: 16)
                                .foregroundStyle(.primary)
                        }
                }
            }
            .fontDesign(.rounded)
        }
        .overlay {
            if isLandscape == false {
                ZStack {
                    Rectangle()
                        .background(.ultraThinMaterial)
                        .ignoresSafeArea()
                    VStack {
                        Image(systemName: "ipad.gen2.landscape")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 128, height: 128)
                            .foregroundStyle(.white)
                        Text("Turn the screen sideways!!")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundStyle(.white)
                    }
                }
            }
        }
        .onAppear {
            onAppearLandscape()
        }
        .onReceive(NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)) { output in
            guard let device = output.object as? UIDevice else { return }
            isLandscape = device.orientation.isLandscape
        }

    }

    func onAppearLandscape() {
        let orientation = UIDevice.current.orientation
        let isLandscape = orientation.isLandscape
        let isFlat = orientation.isFlat
        self.isLandscape = isLandscape || isFlat
    }
}


#Preview {
    ContentView()
}
