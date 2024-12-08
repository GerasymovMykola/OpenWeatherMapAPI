//
//  ContentView.swift
//  OpenWeatherMapAPI

//

import SwiftUI
import MapKit

struct ContentView: View {
    
    @State private var latitude: String = "44.65"
    @State private var longitude: String = "-63.57"
    @State private var temperature: String = "-"
    @State private var weatherDisription: String = "-"
    
    @State private var isLoading: Bool = false
    @State private var showDetails: Bool = false
    @State private var apiError: String? = nil
    
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 44.65, longitude: -63.57),
        span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
    
    var body: some View {
        NavigationStack{
            VStack{
                Text("Weather App")
                    .font(.largeTitle)
                    .padding()
                
                HStack {
                    
                    HStack {
                        Text("Latitude:")
                        TextField("Enter Latitude", text: $latitude)
                            .keyboardType(.decimalPad)
                    }
                    
                    HStack {
                        Text("Longitude:")
                        TextField("Enter Longitude", text: $longitude)
                            .keyboardType(.decimalPad)
                    }
                }.padding()
                
                /*
                 Button("Get weather"){
                 getWeather()
                 }
                 .buttonStyle(.borderedProminent)
                 
                 VStack{
                 Text("Temperature \(temperature) C")
                 Text("Discription \(weatherDisription)")
                 }
                 .font(.headline)
                 */
                
                Map(coordinateRegion: $region).frame(height: 300)
                
                
                NavigationLink(destination: WeatherDetailsView(
                    temperature: temperature,
                    weatherDescription: weatherDisription,
                    latitude: latitude,
                    longitude: longitude
                ), isActive: $showDetails) {
                    Button(action: {
                        getWeather()
                    }) {
                        if isLoading {
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle())
                        } else {
                            Text("Get Weather & Show Details")
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.blue)
                                .cornerRadius(10)
                        }
                    }
                    .disabled(isLoading)
                    
                }
                .padding()
                
                if let error = apiError {
                    Text("Error: \(error)")
                        .foregroundColor(.red)
                        .padding()
                }
                
            }
        }
    }
    
    func getWeather() {
        
        guard let lat = Double(latitude), let lon = Double(longitude) else {
            print("Invalid coordinates")
            return
        }
        
        isLoading = true
        apiError = nil
        
        fetchWeather(lat: lat, lon: lon) { result in
            DispatchQueue.main.async {
                isLoading = false
                switch result {
                case .success(let currentWeather):
                    self.temperature = String(format: "%.1f", currentWeather.main.temp)
                    self.weatherDisription = currentWeather.weather.first?.description ?? "N/A"
                    self.region.center = CLLocationCoordinate2D(latitude: lat, longitude: lon)
                    self.showDetails = true
                case .failure(let error):
                    self.apiError = "Failed to fetch weather: \(error.localizedDescription)"
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
