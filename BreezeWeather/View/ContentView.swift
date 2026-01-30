import SwiftUI
import CoreData   

struct ContentView: View {

    @Environment(\.managedObjectContext)
    private var viewContext

    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(
                    colors: [Color.black, Color.blue.opacity(0.6)],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()

                VStack(spacing: 24) {
                    Image(systemName: "umbrella.fill")
                        .font(.system(size: 80))
                        .foregroundColor(.blue)

                    Text("Breeze")
                        .font(.largeTitle)
                        .foregroundColor(.white)

                    Text("Weather App")
                        .foregroundColor(.gray)

                    NavigationLink {
                        LocationListView()
                            .environment(
                                \.managedObjectContext,
                                viewContext
                            )
                    } label: {
                        Circle()
                            .fill(Color.blue)
                            .frame(width: 60, height: 60)
                            .overlay(
                                Image(systemName: "arrow.right")
                                    .foregroundColor(.white)
                                    .font(.title)
                            )
                    }
                }
            }
        }
    }
}
