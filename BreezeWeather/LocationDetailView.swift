import SwiftUI

struct LocationDetailView: View {

    let location: Location

    @State private var temperature: Double?
    @State private var windSpeed: Double?
    @State private var precipitation: Double?

    private let weatherService = WeatherService(
        networkService: HttpNetworking()
    )

    var body: some View {
        ZStack {
            LinearGradient(
                colors: [Color.black, Color.blue.opacity(0.6)],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            VStack(spacing: 24) {
                Text(location.name)
                    .font(.largeTitle)
                    .foregroundColor(.white)

                Image(systemName: location.weather.icon)
                    .font(.system(size: 120))
                    .foregroundColor(.yellow)

                if let temp = temperature {
                    Text("🌡️ \(Int(temp)) °C")
                        .font(.title2)
                        .foregroundColor(.white)
                }

                if let wind = windSpeed {
                    Text("💨 Wind: \(Int(wind)) km/h")
                        .foregroundColor(.white)
                }

                if let rain = precipitation {
                    Text("🌧️ Rain: \(rain) mm")
                        .foregroundColor(.white)
                }
            }
        }
        .task {
            do {
                let response = try await weatherService.fetchWeather(
                    latitude: location.latitude,
                    longitude: location.longitude
                )

                temperature = response.current.temperature2M
                windSpeed = response.current.windSpeed10M
                precipitation = response.current.precipitation

            } catch {
                print(error)
            }
        }
    }
}
