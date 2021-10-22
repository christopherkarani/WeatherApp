//
//  Weather.swift
//  WeatherApp
//
//  Created by Chris Karani on 21/10/2021.
//

import Foundation


// model data view model with use

public struct Weather {
    let city: String
    let temperature: Int
    let description: String
    let iconName: String
    let maximumTemperature: Int
    let minimumTemperature: Int
    
    
    init(response: WeatherAPIResponse) {
        city = response.name
        temperature = Int(response.main.temp)
        description = response.weather.first?.description ?? ""
        iconName = response.weather.first?.iconName ?? ""
        maximumTemperature = Int(response.main.maximumTemp)
        minimumTemperature = Int(response.main.minimumTemp)
    }
}


extension Date {
    private func isSameDay(date1: Date, date2: Date) -> Bool {
        let diff = Calendar.current.dateComponents([.day], from: date1, to: date2)
        if diff.day == 0 {
            return true
        } else {
            return false
        }
    }
}
extension Array {
    func uniques<T: Hashable>(by keyPath: KeyPath<Element, T>) -> [Element] {
        return reduce([]) { result, element in
            let alreadyExists = (result.contains(where: { $0[keyPath: keyPath] == element[keyPath: keyPath] }))
            return alreadyExists ? result : result + [element]
        }
    }
}

public struct WeatherForecast {
    let list : [WeatherForecastAPIResponse]
    
    
    var nonDuplicateList: [WeatherForecastAPIResponse] {
        return list.uniques(by: \.weekday)
    }
    
    init(response: ForeCastAPIResponse) {
        self.list = response.list
    }
}
