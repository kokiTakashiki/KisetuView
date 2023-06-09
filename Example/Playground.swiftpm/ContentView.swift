import SwiftUI
import KisetuView

struct ContentView: View {
    @State var detail: Kisetu.Detail = Kisetu.🌸.detail()
    @State var nextKisetuDays: Int = 0

    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text(KisetuView.text)
            KisetuView.Card()
            ZStack {
                RoundedRectangle(cornerRadius: 16.0)
                    .foregroundColor(.gray)
                VStack(spacing: 0) {
                    Rectangle()
                        .fill(.clear)
                        .frame(height: 10)
                    HStack {
                        HStack {
                            Text(detail.astronomicalSeasonName.rawValue)
                                .font(.system(size: 30))
                                .foregroundColor(.white)
                            Text(detail.emoji.rawValue)
                                .font(.system(size: 30))
                        }
                    }
                    Text("Next days : \(nextKisetuDays) Day")
                        .font(.system(size: 30))
                        .foregroundColor(.white)
                    Rectangle()
                        .fill(.clear)
                        .frame(height: 10)
                }
            }
            .frame(width: 300)
            .frame(minHeight: 100)
            .frame(maxHeight: 120)
            Button("update") {
                let result = Kisetu.next(detail.kisetu)
                detail = updateDetail(result)
            }
        }
        .onAppear {
            guard let nextKisetuDaysInt = detail.timeUntilNextKisetu() else { return }
            nextKisetuDays = nextKisetuDaysInt
        }
    }
}

extension ContentView {
    private func updateDetail(_ result: Kisetu) -> Kisetu.Detail {
        switch result {
        case .🌸: return Kisetu.🌸.detail()
        case .😎: return Kisetu.😎.detail()
        case .🍁: return Kisetu.🍁.detail()
        case .🧊: return Kisetu.🧊.detail()
        }
    }
}
