import SwiftUI
import KisetuView

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text(KisetuView.text)
        }
    }
}
