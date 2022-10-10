//
//  File.swift
//  Logan_Hackathon_WeatherApp
//
//  Created by DONGWOOK SEO on 2022/10/06.
//

import UIKit

final class DataManager {
    
    
    static var myWeatherViewList: [Weather] = []
    static var myLikes: Int?
    
    // 불러온 모든 도시들의 날씨 데이터
    private var allWeatherDataArray: [Weather] = [
        Weather(iDnum: 0 ,name: "서울", description: .clear, currentTemperature: "27.5°C", currentHumidity: "30 %", maxTemperature: "29°C", minTemperature: "22°C"),
        Weather(iDnum: 1 ,name: "대전", description: .rain, currentTemperature: "27.5°C", currentHumidity: "30 %", maxTemperature: "29°C", minTemperature: "22°C"),
        Weather(iDnum: 2 ,name: "대구", description: .snow, currentTemperature: "27.5°C", currentHumidity: "30 %", maxTemperature: "29°C", minTemperature: "22°C"),
        Weather(iDnum: 3 ,name: "부산", description: .clear, currentTemperature: "27.5°C", currentHumidity: "30 %", maxTemperature: "29°C", minTemperature: "22°C"),
        Weather(isMyList: true,iDnum: 4 , name: "전주", description: .snow, currentTemperature: "27.5°C", currentHumidity: "30 %", maxTemperature: "29°C", minTemperature: "22°C"),
        Weather(iDnum: 5 ,name: "일산", description: .clear, currentTemperature: "27.5°C", currentHumidity: "30 %", maxTemperature: "29°C", minTemperature: "22°C"),
        Weather(iDnum: 6 ,name: "평택", description: .fog, currentTemperature: "27.5°C", currentHumidity: "30 %", maxTemperature: "29°C", minTemperature: "22°C"),
        Weather(iDnum: 7 ,name: "과천", description: .cloud, currentTemperature: "27.5°C", currentHumidity: "30 %", maxTemperature: "29°C", minTemperature: "22°C"),
        Weather(iDnum: 8 ,name: "고양", description: .clear, currentTemperature: "27.5°C", currentHumidity: "30 %", maxTemperature: "29°C", minTemperature: "22°C"),
        Weather(iDnum: 9 ,name: "김포", description: .rain, currentTemperature: "27.5°C", currentHumidity: "30 %", maxTemperature: "29°C", minTemperature: "22°C"),
        Weather(iDnum: 10 ,name: "춘천", description: .rain, currentTemperature: "27.5°C", currentHumidity: "30 %", maxTemperature: "29°C", minTemperature: "22°C"),
        Weather(iDnum: 11 ,name: "안양", description: .rain, currentTemperature: "27.5°C", currentHumidity: "30 %", maxTemperature: "29°C", minTemperature: "22°C"),
        Weather(iDnum: 12 ,name: "충주", description: .rain, currentTemperature: "27.5°C", currentHumidity: "30 %", maxTemperature: "29°C", minTemperature: "22°C"),
        Weather(iDnum: 13 ,name: "마계수원", description: .rain, currentTemperature: "27.5°C", currentHumidity: "30 %", maxTemperature: "29°C", minTemperature: "22°C"),
        Weather(iDnum: 14 ,name: "안산", description: .rain, currentTemperature: "27.5°C", currentHumidity: "30 %", maxTemperature: "29°C", minTemperature: "22°C"),
        Weather(iDnum: 15 ,name: "용인", description: .rain, currentTemperature: "27.5°C", currentHumidity: "30 %", maxTemperature: "29°C", minTemperature: "22°C"),
        Weather(iDnum: 16 ,name: "제주도", description: .rain, currentTemperature: "27.5°C", currentHumidity: "30 %", maxTemperature: "29°C", minTemperature: "22°C"),
        Weather(iDnum: 17 ,name: "1---", description: .rain, currentTemperature: "--", currentHumidity: "--", maxTemperature: "--", minTemperature: "--"),
        Weather(iDnum: 18 ,name: "2---", description: .rain, currentTemperature: "--", currentHumidity: "--", maxTemperature: "--", minTemperature: "--"),
        Weather(iDnum: 19 ,name: "3---", description: .rain, currentTemperature: "--", currentHumidity: "--", maxTemperature: "--", minTemperature: "--"),
        Weather(iDnum: 20 ,name: "4---", description: .rain, currentTemperature: "--", currentHumidity: "--", maxTemperature: "--", minTemperature: "--"),
        Weather(iDnum: 21 ,name: "5---", description: .rain, currentTemperature: "--", currentHumidity: "--", maxTemperature: "--", minTemperature: "--"),
        Weather(iDnum: 22 ,name: "6---", description: .rain, currentTemperature: "--", currentHumidity: "--", maxTemperature: "--", minTemperature: "--"),
        Weather(iDnum: 23 ,name: "7---", description: .rain, currentTemperature: "--", currentHumidity: "--", maxTemperature: "--", minTemperature: "--"),
        Weather(iDnum: 24 ,name: "8---", description: .rain, currentTemperature: "--", currentHumidity: "--", maxTemperature: "--", minTemperature: "--"),
        Weather(iDnum: 25 ,name: "9---", description: .rain, currentTemperature: "--", currentHumidity: "--", maxTemperature: "--", minTemperature: "--"),
    ]
    
    
    
    func addMyWeatherViewList(index:Int) {
        print(#function)
        allWeatherDataArray[index].isMyList.toggle()
        setMyWeatherViewList()
    }
    
    //유저가 선택한 특정도시들의 날씨 추출
    func setMyWeatherViewList() {
        print(#function)
        
        DataManager.myWeatherViewList = allWeatherDataArray.filter{ $0.isMyList }
        var myArr = DataManager.myWeatherViewList
        myArr.forEach{
            guard let num = DataManager.myLikes else {return}
            if $0.iDnum == num {
                myArr.remove(at: num)
                myArr.append($0)
            }
        }
        DataManager.myWeatherViewList = myArr
    }
    
    func getMyWeatherViewList() -> [Weather] {
        return DataManager.myWeatherViewList
    }
    
    func getAllWeatherList() -> [Weather] {
        return allWeatherDataArray
    }
}
