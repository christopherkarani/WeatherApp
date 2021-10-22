//
//  ForcastCell.swift
//  WeatherApp
//
//  Created by Chris Karani on 21/10/2021.
//

import SwiftUI

extension Date {
    static func getWeekDay(from time: TimeInterval) -> String{
           let dateFormatter = DateFormatter()
           dateFormatter.dateFormat = "EEEE"
           let weekDay = dateFormatter.string(from: Date(timeIntervalSince1970: time))
           return weekDay
     }
}




/*
 struct WeatherForecastAPIResponse: Decodable {
     let dt: Int
     let main: APIMain
     let weather: [APIWeather]
 }
 
 */
struct ForcastCell: View {
    
    var date : String {
        String(DateFormatter.localizedString(from: Date(timeIntervalSince1970: dateTime), dateStyle: .medium, timeStyle: .short))
    }
    
    let dateTime: Double
    let temp: Int
    let imageString: String
    
    
    var imageSize: CGFloat = 28
    var body: some View {
        HStack {
            Text(Date.getWeekDay(from:dateTime))
                .foregroundColor(.white)
                .font(.system(size: 16, weight: .medium, design: .rounded))
                .frame(alignment: .trailing)
                .padding()
            Spacer()
            //.frame(width: UIScreen.screenWidth / 3)
            Image(imageString)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: imageSize, height: imageSize, alignment: .center)
            Spacer()
                .frame(width: UIScreen.screenWidth / 3.85)
            Text("\(temp)°")
                .foregroundColor(.white)
                .font(.system(size: 16, weight: .medium, design: .rounded))
                .frame(alignment: .leading)
                .padding()
        }
    }
}

struct ForcastCell_Previews: PreviewProvider {
    static var previews: some View {
        ForcastCell(dateTime: 1596564000, temp: 28, imageString: "clear")
    }
}
