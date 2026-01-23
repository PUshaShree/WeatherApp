import Foundation

struct WeatherResponse: Codable {
    let current: Current
}

struct Current: Codable {
    let temperature2M: Double
    let windSpeed10M: Double
    let precipitation: Double

    enum CodingKeys: String, CodingKey {
        case temperature2M = "temperature_2m"
        case windSpeed10M = "wind_speed_10m"
        case precipitation
    }
}
