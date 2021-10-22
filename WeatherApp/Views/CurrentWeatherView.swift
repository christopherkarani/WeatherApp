//
//  CurrentWeatherView.swift
//  WeatherApp
//
//  Created by Chris Karani on 20/10/2021.
//

import SwiftUI

struct CurrentWeatherTextView: View {
    enum Spectrum {
        case minimum
        case maximum
        case current
    }
    
    let spectrum: Spectrum
    let inputText: String
    
    var text : String {
        return inputText.appending("°")
    }
    
    var body: some View {
        VStack {
            Text(text)
                .font(.system(size: 20, weight: .medium, design: .rounded))
                .foregroundColor(.white)
            switch spectrum {
            case .minimum:
                Text("Min")
                    .foregroundColor(.white)
                    .font(.system(size: 14, weight: .light, design: .rounded))
            case .maximum:
                Text("Max")
                    .foregroundColor(.white)
                    .font(.system(size: 14, weight: .light, design: .rounded))
            case .current:
                Text("Current")
                    .foregroundColor(.white)
                    .font(.system(size: 14, weight: .light, design: .rounded))
            }
        }.padding()
    }
}

struct CurrentWeatherView: View {
    let minimum: Int
    let current: Int
    let maximum: Int
    
    var body: some View {
        HStack {
            CurrentWeatherTextView(spectrum: .minimum, inputText: "\(minimum)")
                .padding()
            Spacer()
            CurrentWeatherTextView(spectrum: .current, inputText:  "\(current)")
            Spacer()
            CurrentWeatherTextView(spectrum: .maximum, inputText:  "\(maximum)")
                .padding()
        }
        .background(Color.skyblue)
    }
}

struct CurrentWeatherView_Previews: PreviewProvider {
    static var previews: some View {
        CurrentWeatherView(minimum: 22, current: 23, maximum: 23)
    }
}
