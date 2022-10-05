//
//  File.swift
//  Logan_Hackathon_WeatherApp
//
//  Created by DONGWOOK SEO on 2022/10/06.
//

import UIKit

class DataManager {
    var weatherDataArray: [Weather] = []
    
    func makeMovieData() {
        weatherDataArray = [
            Weather(name: "서울", icon: UIImage(systemName: "sun.max")!, description: .clear, currentDegree: 27.5, currentTemperature: 30.0, maxTemperature: 29, minTemperature: 22),
            Weather(name: "대전", icon: UIImage(systemName: "sun.max")!, description: .clear, currentDegree: 27.5, currentTemperature: 30.0, maxTemperature: 29, minTemperature: 22),
            Weather(name: "대구", icon: UIImage(systemName: "sun.max")!, description: .clear, currentDegree: 27.5, currentTemperature: 30.0, maxTemperature: 29, minTemperature: 22),
            Weather(name: "부산", icon: UIImage(systemName: "sun.max")!, description: .clear, currentDegree: 27.5, currentTemperature: 30.0, maxTemperature: 29, minTemperature: 22),
            Weather(name: "전주", icon: UIImage(systemName: "sun.max")!, description: .clear, currentDegree: 27.5, currentTemperature: 30.0, maxTemperature: 29, minTemperature: 22),
            ]
    }
    
    func getWeatherData() -> [Weather] {
        return weatherDataArray
    }
}
