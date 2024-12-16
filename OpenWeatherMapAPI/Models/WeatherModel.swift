//MH

import Foundation

struct WeatherResponse: Codable {
    let weather: [WeatherDetail]
    let main: MainWeather
    let name: String
}

struct WeatherDetail: Codable {
    let description: String
    let icon: String
}

struct MainWeather: Codable {
    let temp: Double
}



