//
//  OpenWeatherMapAPI
//
//

import Foundation

struct WeatherResponse: Codable{
    let current: CurrentWeather
}

struct CurrentWeather: Codable{
    let temb: Double
    let weather: [WeatherDetail]
}

struct WeatherDetail: Codable{
    let description: String
}


func fetchWeather(lat: Double, lon: Double, completion: @escaping (Result<CurrentWeather, Error>) -> Void) {
   
    // Zdarov Nazar
    
    let apiKey = "2b1f203c6ee223c4c4f4a05bb344dac8"
    let urlString = "https://api.openweathermap.org/data/3.0/onecall?lat=\(lat)&lon=\(lon)&units=metric&lang=uk&appid=\(apiKey)"

    guard let url = URL(string: urlString) else {
        print("Uncorrect URL")
        return
    }

    let task = URLSession.shared.dataTask(with: url) { data, response, error in
        if let error = error {
            completion(.failure(error))
            return
        }

        if let data = data {
            do {
                let weatherResponse = try JSONDecoder().decode(WeatherResponse.self, from: data)
                completion(.success(weatherResponse.current))
            } catch {
                completion(.failure(error))
            }
        }
    }
    task.resume()
}
