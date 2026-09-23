import SwiftUI
import Playgrounds

struct ContentView: View {
    @State private var value: Double = 50;
    
    var body: some View {
        #if os(iOS)
        iPhoneView()
        #else
        MacView()
        #endif
    }
}

#Preview {
    ContentView()
}

#Playground {
    _ = 1 + 2
}
