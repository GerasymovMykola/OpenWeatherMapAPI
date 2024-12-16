//
//  WeatherService.swift
//  OpenWeatherMapAPI


import Foundation


class WeatherService {
    
    static let shared = WeatherService()
    
    private init() {}
    
    func fetchWeather(lat: Double, lon: Double, completion: @escaping (Result<WeatherResponse, Error>) -> Void) {
        
        let apiKey = "2b1f203c6ee223c4c4f4a05bb344dac8"
        let urlString = "https://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(lon)&units=metric&lang=uk&appid=\(apiKey)"
        
        
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
                
                if let jsonString = String(data: data, encoding: .utf8) {
                    print("Response JSON: \(jsonString)")
                }
                
                do {
                 let weatherResponse = try JSONDecoder().decode(WeatherResponse.self, from: data)
                 completion(.success(weatherResponse))
                 } catch {
                 completion(.failure(error))
                 }
                
            }
        }
        task.resume()
    }
    
}
