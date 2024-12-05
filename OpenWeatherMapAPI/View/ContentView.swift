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
    
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 44.65, longitude: -63.57),
        span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
    
    var body: some View {
        VStack{
            Text("Weather App")
                .font(.largeTitle)
                .padding()
            
            HStack {
                
                VStack {
                    Text("Latitude:")
                    TextField("Enter Latitude", text: $latitude)
                        .keyboardType(.decimalPad)
                }
                
                VStack {
                    Text("Longitude:")
                    TextField("Enter Longitude", text: $longitude)
                        .keyboardType(.decimalPad)
                }
            }.padding()
            
            Button("Get weather"){
                getWeather()
            }
            .buttonStyle(.borderedProminent)
            
            VStack{
                Text("Temperature \(temperature) C")
                Text("Discription \(weatherDisription)")
            }
            .font(.headline)
            
            Map(coordinateRegion: $region).frame(height: 300)
            
        }
    }
    
    func getWeather() {
        
        guard let lat = Double(latitude), let lon = Double(longitude) else {
            print("Invalid coordinates")
            return
        }
        
        fetchWeather(lat: lat, lon: lon) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let currentWeather):
                    self.temperature = String(format: "%.1f", currentWeather.temb)
                    self.weatherDisription = currentWeather.weather.first?.description ?? "N/A"
                    self.region.center = CLLocationCoordinate2D(latitude: lat, longitude: lon)
                case .failure(let error):
                    print("Error fetching weather: \(error)")
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
