import SwiftUI

struct LocationListView: View {
    var body: some View {
        List(locations) { location in
            NavigationLink {
                LocationDetailView(location: location)
            } label: {
                HStack {
                    Text(location.name)
                        .foregroundColor(.white)
                    
                    Spacer()
                    
                    Image(systemName: location.weather.icon)
                        .foregroundColor(.yellow)
                }
                .padding(.vertical, 8)
            }
            .listRowBackground(Color.clear)
        }
        .scrollContentBackground(.hidden)
        .background(Color.black)
        .navigationTitle("Locations")
    }
}
