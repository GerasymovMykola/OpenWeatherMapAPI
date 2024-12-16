//
//  ContentView.swift
//  OpenWeatherMapAPI

//

import SwiftUI
import MapKit

struct ContentView: View {
    
    @ObservedObject private var viewModel = WeatherViewModel()
    
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
                        TextField("Enter Latitude", text: $viewModel.latitude)
                            .keyboardType(.decimalPad)
                    }
                    
                    HStack {
                        Text("Longitude:")
                        TextField("Enter Longitude", text: $viewModel.longitude)
                            .keyboardType(.decimalPad)
                    }
                }.padding()
                
                Map(coordinateRegion: $region).frame(height: 300)
                
                NavigationLink(destination: WeatherDetailsView(
                    temperature: viewModel.temperature,
                    weatherDescription: viewModel.weatherDisription,
                    latitude: viewModel.latitude,
                    longitude: viewModel.longitude
                ), isActive: $viewModel.showDetails) {
                    Button(action: {
                        viewModel.getWeather()
                    }) {
                        if viewModel.isLoading {
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
                    .disabled(viewModel.isLoading)
                    
                }
                .padding()
                
                if let error = viewModel.apiError {
                    Text("Error: \(error)")
                        .foregroundColor(.red)
                        .padding()
                }
                
            }
        }
    }
    
}

#Preview {
    ContentView()
}
