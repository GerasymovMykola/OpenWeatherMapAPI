//
//  WeatherDetailsView.swift
//  OpenWeatherMapAPI
//

import SwiftUI

struct WeatherDetailsView: View {
    
    let temperature: String
    let weatherDescription: String
    let latitude: String
    let longitude: String
    
    var body: some View {
        VStack {
            Text("Weather Details")
                .font(.largeTitle)
                .padding()
            
            Text("Temperature: \(temperature)°C")
                .font(.headline)
            
            Text("Description: \(weatherDescription)")
                .font(.subheadline)
            
            Text("Location: \(latitude), \(longitude)")
                .font(.subheadline)
            
            Spacer()
        }
        .padding()
    }
}

#Preview {
    WeatherDetailsView(temperature: "20.0",
                       weatherDescription: "Clear sky",
                       latitude: "44.65",
                       longitude: "-63.57")
}
