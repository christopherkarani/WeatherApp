//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by Chris Karani on 21/10/2021.
//

import Foundation

public class WeatherViewModel: ObservableObject {
    @Published var cityName: String = "City Name"
    @Published var temperature: Int = 0
    @Published var weatherDescription: String = "--"
  //  @Published var weatherIcon: String = defaultIcon
    @Published var maximumTemperature: Int = 0
    @Published var minimumTemperature: Int = 0
    
    public let weatherService: WeatherService
    
    public init(weatherService: WeatherService) {
        self.weatherService = weatherService
    }
    
    public func refresh() {
        weatherService.loadWeatherData { weather in
            DispatchQueue.main.async {
                self.cityName = weather.city
                self.temperature = weather.temperature
                self.weatherDescription = weather.description
             //   self.weatherIcon = iconMap[weather.iconName] ?? ""
                self.maximumTemperature = weather.maximumTemperature
                self.minimumTemperature = weather.minimumTemperature
            }
        }
    }
}

public class WeatherForecaseViewModel: ObservableObject {
    
    @Published var list = [WeatherForecastAPIResponse]()
    
    public let weatherService: WeatherService
    
    public init(weatherService: WeatherService) {
        self.weatherService = weatherService
    }
    
    public func refresh() {
        weatherService.loadWeatherForecastData { forecast in
            DispatchQueue.main.async {
                self.list = forecast.nonDuplicateList
            }
        }
    }
}
