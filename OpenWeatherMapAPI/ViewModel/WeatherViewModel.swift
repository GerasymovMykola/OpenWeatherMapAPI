//
//  WeatherViewModel.swift
//  OpenWeatherMapAPI
//

import Foundation
import Combine

class WeatherViewModel: ObservableObject {
    
    @Published var latitude: String = "44.65"
    @Published var longitude: String = "-63.57"
    @Published var temperature: String = "-"
    @Published var weatherDisription: String = "-"
    
    @Published var isLoading: Bool = false
    @Published var showDetails: Bool = false
    @Published var apiError: String? = nil
    
    func getWeather() {
        
        guard let lat = Double(latitude), let lon = Double(longitude) else {
            print("Invalid coordinates")
            return
        }
        
        isLoading = true
        apiError = nil
        
        WeatherService.shared.fetchWeather(lat: lat, lon: lon) { result in
            DispatchQueue.main.async {
                self.isLoading = false
                switch result {
                case .success(let currentWeather):
                    self.temperature = String(format: "%.1f", currentWeather.main.temp)
                    self.weatherDisription = currentWeather.weather.first?.description ?? "N/A"
                    //self.region.center = CLLocationCoordinate2D(latitude: lat, longitude: lon)
                    self.showDetails = true
                case .failure(let error):
                    self.apiError = "Failed to fetch weather: \(error.localizedDescription)"
                }
            }
        }
    }
    
}
