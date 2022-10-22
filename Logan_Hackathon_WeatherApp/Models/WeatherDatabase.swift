//
//  WeatherDatabase.swift
//  Logan_Hackathon_WeatherApp
//
//  Created by DONGWOOK SEO on 2022/10/11.
//

import UIKit

final class WeatherDatabase {
    
     static var allDataArray: [Weather] = [
        Weather(iDnum: 0 ,name: "서울", description: .clear, currentTemperature: "10°C", currentHumidity: "77 %", maxTemperature: "29°C", minTemperature: "22°C"),
        Weather(iDnum: 1 ,name: "대전", description: .rain, currentTemperature: "11°C", currentHumidity: "70 %", maxTemperature: "29°C", minTemperature: "22°C"),
        Weather(iDnum: 2 ,name: "대구", description: .snow, currentTemperature: "13°C", currentHumidity: "68 %", maxTemperature: "29°C", minTemperature: "22°C"),
        Weather(iDnum: 3 ,name: "부산", description: .clear, currentTemperature: "14°C", currentHumidity: "71 %", maxTemperature: "29°C", minTemperature: "22°C"),
        Weather(iDnum: 4 , name: "전주", description: .rain, currentTemperature: "12°C", currentHumidity: "79 %", maxTemperature: "20°C", minTemperature: "5°C"),
        Weather(iDnum: 5 ,name: "일산", description: .clear, currentTemperature: "11°C", currentHumidity: "77 %", maxTemperature: "29°C", minTemperature: "7°C"),
        Weather(iDnum: 6 ,name: "평택", description: .fog, currentTemperature: "12°C", currentHumidity: "69 %", maxTemperature: "29°C", minTemperature: "6°C"),
        Weather(iDnum: 7 ,name: "과천", description: .cloud, currentTemperature: "9°C", currentHumidity: "73 %", maxTemperature: "19°C", minTemperature: "5°C"),
        Weather(iDnum: 8 ,name: "고양", description: .clear, currentTemperature: "11°C", currentHumidity: "75 %", maxTemperature: "29°C", minTemperature: "9°C"),
        Weather(iDnum: 9 ,name: "김포", description: .rain, currentTemperature: "10°C", currentHumidity: "67 %", maxTemperature: "29°C", minTemperature: "8°C"),
        Weather(iDnum: 10 ,name: "춘천", description: .rain, currentTemperature: "13°C", currentHumidity: "70 %", maxTemperature: "29°C", minTemperature: "6°C"),
        Weather(iDnum: 11 ,name: "안양", description: .rain, currentTemperature: "11°C", currentHumidity: "66 %", maxTemperature: "29°C", minTemperature: "9°C"),
        Weather(iDnum: 12 ,name: "충주", description: .rain, currentTemperature: "11°C", currentHumidity: "75 %", maxTemperature: "29°C", minTemperature: "5°C"),
        Weather(iDnum: 13 ,name: "수원", description: .rain, currentTemperature: "9°C", currentHumidity: "69 %", maxTemperature: "19°C", minTemperature: "5°C"),
        Weather(iDnum: 14 ,name: "안산", description: .rain, currentTemperature: "11°C", currentHumidity: "67 %", maxTemperature: "29°C", minTemperature: "6°C"),
        Weather(iDnum: 15 ,name: "용인", description: .rain, currentTemperature: "10°C", currentHumidity: "74 %", maxTemperature: "29°C", minTemperature: "7°C"),
        Weather(iDnum: 16 ,name: "제주도", description: .rain, currentTemperature: "14°C", currentHumidity: "69 %", maxTemperature: "19°C", minTemperature: "13°C"),
        Weather(iDnum: 17 ,name: "브리즈번", description: .clear, currentTemperature: "18°C", currentHumidity: "61 %", maxTemperature: "25°C", minTemperature: "16°C"),
        Weather(iDnum: 18 ,name: "캔버라", description: .cloud, currentTemperature: "11°C", currentHumidity: "84 %", maxTemperature: "20°C", minTemperature: "8°C"),
        Weather(iDnum: 19 ,name: "맬버른", description: .cloud, currentTemperature: "15°C", currentHumidity: "76 %", maxTemperature: "19°C", minTemperature: "13°C"),
        Weather(iDnum: 20 ,name: "뉴욕", description: .clear, currentTemperature: "13°C", currentHumidity: "67 %", maxTemperature: "21°C", minTemperature: "11°C"),
        Weather(iDnum: 21 ,name: "라스베이거스", description: .clear, currentTemperature: "20°C", currentHumidity: "30 %", maxTemperature: "33°C", minTemperature: "18°C"),
        Weather(iDnum: 22 ,name: "파리", description: .clear, currentTemperature: "15°C", currentHumidity: "56 %", maxTemperature: "17°C", minTemperature: "9°C"),
        Weather(iDnum: 23 ,name: "런던", description: .cloud, currentTemperature: "16°C", currentHumidity: "50 %", maxTemperature: "16°C", minTemperature: "6°C"),
        Weather(iDnum: 24 ,name: "마드리드", description: .clear, currentTemperature: "22°C", currentHumidity: "56%", maxTemperature: "23°C", minTemperature: "23°C"),
        Weather(iDnum: 25 ,name: "로마", description: .cloud, currentTemperature: "27°C", currentHumidity: "47 %", maxTemperature: "27°C", minTemperature: "15°C")
    ]
    
    func getAllDataFromBase() -> [Weather] {
        return WeatherDatabase.allDataArray
    }
    
    func getAWeatherData(name:String) -> [Weather] {
        
        let data = getAllDataFromBase().filter{$0.name == name}
        return data
    }
    
    
    
}

