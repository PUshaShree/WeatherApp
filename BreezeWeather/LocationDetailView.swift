import SwiftUI

struct LocationDetailView: View {

    let location: Location

    @State private var temperature: Double?
    @State private var windSpeed: Double?
    @State private var precipitation: Double?
    @State private var surfacePressure: Double?

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


                VStack(spacing: 25) {
                    HStack(spacing: 25) {
                        weatherCard(
                            title: "TEMP",
                            value: temperature.map { "\(Int($0))°" } ?? "--"
                        )

                        weatherCard(
                            title: "WIND",
                            value: windSpeed.map { "\(Int($0)) km/h" } ?? "--"
                        )
                    }

                    HStack(spacing: 16) {
                        weatherCard(
                            title: "PRESSURE",
                            value: surfacePressure.map { "\(Int($0)) hPa" } ?? "--"
                        )

                        weatherCard(
                            title: "RAIN",
                            value: precipitation.map { "\(String(format: "%.1f", $0)) mm" } ?? "--"
                        )
                    }
                }
                .padding(.top, 12)

                Spacer()
            }
            .padding()
        }
        .task {
            do {
                let response = try await weatherService.fetchWeather(
                    latitude: location.latitude,
                    longitude: location.longitude
                )

                temperature      = response.current.temperature2M
                windSpeed        = response.current.windSpeed10M
                precipitation    = response.current.precipitation
                surfacePressure  = response.current.surfacePressure   
            } catch {
                print(error)
            }
        }
    }

    private func weatherCard(title: String, value: String) -> some View {
        VStack(spacing: 8) {
            Text(title)
                .font(.caption)
                .foregroundColor(.gray)

            Text(value)
                .font(.title3)
                .fontWeight(.semibold)
                .foregroundColor(.white)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color.white.opacity(0.12))
        .cornerRadius(14)
    }
}
