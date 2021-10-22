//
//  ContentView.swift
//  WeatherApp
//
//  Created by Chris Karani on 20/10/2021.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: WeatherViewModel
    @ObservedObject var forecastViewModel: WeatherForecaseViewModel
    var body: some View {
        VStack {
            ZStack {
                Color.skyblue
                    .edgesIgnoringSafeArea(.all)
                GeometryReader { geo in
                    // If statement
                    Image("sea_sunny")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: geo.size.width)
                }
                VStack {
                    Text("\(viewModel.temperature)")
                        .foregroundColor(.white)
                        .font(.system(size: 53, weight: .heavy, design: .monospaced))
                    Text(viewModel.weatherDescription)
                        .foregroundColor(.white)
                        .font(.system(size: 53, weight: .medium, design: .monospaced))
                    Spacer()
                        .frame(height: 100, alignment: .center)
                }
            }
            .edgesIgnoringSafeArea(.all)
            .frame(height: UIScreen.screenHeight / 2.2, alignment: .center)
            CurrentWeatherView(
                minimum: viewModel.minimumTemperature,
                current: viewModel.temperature,
                maximum: viewModel.maximumTemperature)
                .frame(height: 20, alignment: .center)
            Divider()
                .background(Color.white)
                .frame(height: 10)
            List(forecastViewModel.list) { item in
                ForcastCell(
                    dateTime: Double(item.dt),
                    temp: Int(item.main.temp),
                    imageString: "clear"
                ).listRowBackground(Color.skyblue)
            }
            .listStyle(.grouped)
            .onAppear(perform: {
                UITableView.appearance().contentInset.top = -35
                UITableView.appearance().separatorColor = .clear
                UITableView.appearance().isScrollEnabled = false
                viewModel.refresh()
                forecastViewModel.refresh()
            })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView(
                viewModel:WeatherViewModel(weatherService: WeatherService()),
                forecastViewModel: WeatherForecaseViewModel(weatherService: WeatherService())
            )
        }
    }
}
