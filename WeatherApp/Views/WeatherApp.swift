//
//  WeatherAppApp.swift
//  WeatherApp
//
//  Created by Chris Karani on 20/10/2021.
//

import SwiftUI

@main
struct WeatherApp: App {
    var body: some Scene {
        WindowGroup {
            let weatherService = WeatherService()
            let viewModel = WeatherViewModel(weatherService: weatherService)
            ContentView(viewModel: viewModel, forecastViewModel: WeatherForecaseViewModel(weatherService: weatherService))
        }
    }
}
