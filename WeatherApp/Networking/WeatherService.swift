//
//  Weather.swift
//  WeatherApp
//
//  Created by Chris Karani on 21/10/2021.
//

import Foundation
import CoreLocation
import SwiftUI

let apiCall = "api.openweathermap.org/data/2.5/weather?lat={lat}&lon={lon}&appid={API key}"


public final class WeatherService: NSObject {
    private let locationManager = CLLocationManager()
    private let API_Key = "fd1ad25a5386eb80e2767b32ca3de7ea"
    private var handler: ((Weather) -> Void)?
    private var forecastHandler: ((WeatherForecast) -> Void)?
    private var flagAPICalled: Bool = false
    
    
    public override init() {
        super.init()
        locationManager.delegate = self
    }
    
    public func loadWeatherData(_ completionHandler: @escaping ((Weather) -> Void)) {
        self.handler = completionHandler
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    public func loadWeatherForecastData(_ completionHandler: @escaping ((WeatherForecast) -> Void)) {
        self.forecastHandler = completionHandler
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    
    // https://api.openweathermap.org/data/2.5/weather?lat={lat}&lon={lon}&appid={API key}
    private func makeDataRequest(forCoordinates coordinates: CLLocationCoordinate2D) {
        guard let urlString = "https://api.openweathermap.org/data/2.5/weather?lat=\(coordinates.latitude)&lon=\(coordinates.longitude)&appid=\(API_Key)&units=metric".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard error == nil, let data = data else { return }
            if let response = try? JSONDecoder().decode(WeatherAPIResponse.self, from: data) {
                self.handler?(Weather(response: response))
            }
        }.resume()
    }
    
    // https://api.openweathermap.org/data/2.5/forecast?lat={lat}&lon={lon}&appid={API key}
    private func makeDataRequestForecast(forCoordinates coordinates: CLLocationCoordinate2D) {
        guard let urlString = "https://api.openweathermap.org/data/2.5/forecast?lat=\(coordinates.latitude)&lon=\(coordinates.longitude)&appid=\(API_Key)&units=metric&count=1".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard error == nil, let data = data else { return }
           
            if let response = try? JSONDecoder().decode(ForeCastAPIResponse.self, from: data) {
                self.forecastHandler?(WeatherForecast(response: response))
            }
        }.resume()
    }
}

extension WeatherService: CLLocationManagerDelegate {
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        guard !flagAPICalled else { return  }
        makeDataRequest(forCoordinates: location.coordinate)
        makeDataRequestForecast(forCoordinates: location.coordinate)
        flagAPICalled = true
    }
    
    public func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Something went Wrong: ", error.localizedDescription)
    }
}

struct WeatherAPIResponse: Decodable {
    let dt: Int
    let name: String
    let main: APIMain
    let weather: [APIWeather]
}

struct WeatherForecastAPIResponse: Decodable {
    let dt: Int
    let main: APIMain
    let weather: [APIWeather]
    
    var weekday: String {
        Date.getWeekDay(from: Double(dt))
    }
}

extension WeatherForecastAPIResponse: Identifiable {
    var id: Int {
        return dt
    }
}

struct ForeCastAPIResponse: Decodable {
    let list : [WeatherForecastAPIResponse]
}

struct APIMain: Decodable {
    let temp: Double
    let minimumTemp: Double
    let maximumTemp: Double
    
    enum CodingKeys: String, CodingKey {
        case temp
        case minimumTemp = "temp_min"
        case maximumTemp = "temp_max"
    }
    
}

struct APIWeather: Decodable {
    let description: String
    let iconName: String
    
    enum CodingKeys: String, CodingKey {
        case description
        case iconName = "main"
    }
}
