//
//  File.swift
//  Logan_Hackathon_WeatherApp
//
//  Created by DONGWOOK SEO on 2022/10/06.
//

import UIKit

class DataManager {
    // 선택된 날씨 데이터
    static var selectedCity: [String] = [
        "서울","대전", "대구", "부산", "전주", "과천","고양","김포"
    ]
    
    var weatherDataOut: [Weather] = []
    
    // 불러온 모든 도시들의 날씨 데이터
    var weatherDataArray: [Weather] = [
        Weather(name: "서울", description: .clear, currentTemperature: "27.5°C", currentHumidity: "30.0 %", maxTemperature: "29°C", minTemperature: "22°C"),
        Weather(name: "대전", description: .rain, currentTemperature: "27.5°C", currentHumidity: "30.0 %", maxTemperature: "29°C", minTemperature: "22°C"),
        Weather(name: "대구", description: .snow, currentTemperature: "27.5°C", currentHumidity: "30.0 %", maxTemperature: "29°C", minTemperature: "22°C"),
        Weather(name: "부산", description: .clear, currentTemperature: "27.5°C", currentHumidity: "30.0 %", maxTemperature: "29°C", minTemperature: "22°C"),
        Weather(name: "전주", description: .snow, currentTemperature: "27.5°C", currentHumidity: "30.0 %", maxTemperature: "29°C", minTemperature: "22°C"),
        Weather(name: "일산", description: .clear, currentTemperature: "27.5°C", currentHumidity: "30.0 %", maxTemperature: "29°C", minTemperature: "22°C"),
        Weather(name: "평택", description: .fog, currentTemperature: "27.5°C", currentHumidity: "30.0 %", maxTemperature: "29°C", minTemperature: "22°C"),
        Weather(name: "과천", description: .cloud, currentTemperature: "27.5°C", currentHumidity: "30.0 %", maxTemperature: "29°C", minTemperature: "22°C"),
        Weather(name: "고양", description: .clear, currentTemperature: "27.5°C", currentHumidity: "30.0 %", maxTemperature: "29°C", minTemperature: "22°C"),
        Weather(name: "김포", description: .rain, currentTemperature: "27.5°C", currentHumidity: "30.0 %", maxTemperature: "29°C", minTemperature: "22°C")
        ]
    
    // 유저가 선택한 특정도시들의 날씨 추출
    func makeWeatherData() {
        weatherDataArray.forEach{ weatherArr in
            if DataManager.selectedCity.filter({$0.contains(weatherArr.name)}).isEmpty != true {
                weatherDataOut.append(weatherArr)
            }
        }
    }
    
    func getWeatherData() -> [Weather] {
        return weatherDataOut
    }
}
