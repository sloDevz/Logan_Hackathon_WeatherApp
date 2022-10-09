//
//  File.swift
//  Logan_Hackathon_WeatherApp
//
//  Created by DONGWOOK SEO on 2022/10/06.
//

import UIKit

final class DataManager {
    // 선택된 날씨 데이터
    static var myCityNameList: [String] = [
        "전주"
    ]
    
    var myWeatherViewList: [Weather] = []
    
    // 불러온 모든 도시들의 날씨 데이터
    var allWeatherDataArray: [Weather] = [
        Weather(name: "서울", description: .clear, currentTemperature: "27.5°C", currentHumidity: "30 %", maxTemperature: "29°C", minTemperature: "22°C"),
        Weather(name: "대전", description: .rain, currentTemperature: "27.5°C", currentHumidity: "30 %", maxTemperature: "29°C", minTemperature: "22°C"),
        Weather(name: "대구", description: .snow, currentTemperature: "27.5°C", currentHumidity: "30 %", maxTemperature: "29°C", minTemperature: "22°C"),
        Weather(name: "부산", description: .clear, currentTemperature: "27.5°C", currentHumidity: "30 %", maxTemperature: "29°C", minTemperature: "22°C"),
        Weather(name: "전주", description: .snow, currentTemperature: "27.5°C", currentHumidity: "30 %", maxTemperature: "29°C", minTemperature: "22°C"),
        Weather(name: "일산", description: .clear, currentTemperature: "27.5°C", currentHumidity: "30 %", maxTemperature: "29°C", minTemperature: "22°C"),
        Weather(name: "평택", description: .fog, currentTemperature: "27.5°C", currentHumidity: "30 %", maxTemperature: "29°C", minTemperature: "22°C"),
        Weather(name: "과천", description: .cloud, currentTemperature: "27.5°C", currentHumidity: "30 %", maxTemperature: "29°C", minTemperature: "22°C"),
        Weather(name: "고양", description: .clear, currentTemperature: "27.5°C", currentHumidity: "30 %", maxTemperature: "29°C", minTemperature: "22°C"),
        Weather(name: "김포", description: .rain, currentTemperature: "27.5°C", currentHumidity: "30 %", maxTemperature: "29°C", minTemperature: "22°C"),
        Weather(name: "춘천", description: .rain, currentTemperature: "27.5°C", currentHumidity: "30 %", maxTemperature: "29°C", minTemperature: "22°C"),
        Weather(name: "안양", description: .rain, currentTemperature: "27.5°C", currentHumidity: "30 %", maxTemperature: "29°C", minTemperature: "22°C"),
        Weather(name: "충주", description: .rain, currentTemperature: "27.5°C", currentHumidity: "30 %", maxTemperature: "29°C", minTemperature: "22°C"),
        Weather(name: "마계수원", description: .rain, currentTemperature: "27.5°C", currentHumidity: "30 %", maxTemperature: "29°C", minTemperature: "22°C"),
        Weather(name: "안산", description: .rain, currentTemperature: "27.5°C", currentHumidity: "30 %", maxTemperature: "29°C", minTemperature: "22°C"),
        Weather(name: "용인", description: .rain, currentTemperature: "27.5°C", currentHumidity: "30 %", maxTemperature: "29°C", minTemperature: "22°C"),
        Weather(name: "제주도", description: .rain, currentTemperature: "27.5°C", currentHumidity: "30 %", maxTemperature: "29°C", minTemperature: "22°C"),
        Weather(name: "1---", description: .rain, currentTemperature: "--", currentHumidity: "--", maxTemperature: "--", minTemperature: "--"),
        Weather(name: "2---", description: .rain, currentTemperature: "--", currentHumidity: "--", maxTemperature: "--", minTemperature: "--"),
        Weather(name: "3---", description: .rain, currentTemperature: "--", currentHumidity: "--", maxTemperature: "--", minTemperature: "--"),
        Weather(name: "4---", description: .rain, currentTemperature: "--", currentHumidity: "--", maxTemperature: "--", minTemperature: "--"),
        Weather(name: "5---", description: .rain, currentTemperature: "--", currentHumidity: "--", maxTemperature: "--", minTemperature: "--"),
        Weather(name: "6---", description: .rain, currentTemperature: "--", currentHumidity: "--", maxTemperature: "--", minTemperature: "--"),
        Weather(name: "7---", description: .rain, currentTemperature: "--", currentHumidity: "--", maxTemperature: "--", minTemperature: "--"),
        Weather(name: "8---", description: .rain, currentTemperature: "--", currentHumidity: "--", maxTemperature: "--", minTemperature: "--"),
        Weather(name: "9---", description: .rain, currentTemperature: "--", currentHumidity: "--", maxTemperature: "--", minTemperature: "--"),
        ]
    
    func addMyCityList(_ cityName: String) {
        DataManager.myCityNameList.append(cityName)
    }
    
    // 유저가 선택한 특정도시들의 날씨 추출
    func setMyWeatherViewList() {
        myWeatherViewList.removeAll()
        allWeatherDataArray.forEach{ weatherArr in
            if DataManager.myCityNameList.filter({$0.contains(weatherArr.name)}).isEmpty != true {
                myWeatherViewList.append(weatherArr)
            }
        }
    }
    
    func getMyWeatherViewList() -> [Weather] {
        return myWeatherViewList
    }
    
    func getAllWeatherList() -> [Weather] {
        return allWeatherDataArray
    }
}
