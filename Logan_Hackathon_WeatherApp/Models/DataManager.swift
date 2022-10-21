//
//  File.swift
//  Logan_Hackathon_WeatherApp
//
//  Created by DONGWOOK SEO on 2022/10/06.
//

import UIKit

final class DataManager {
    // 베이스 데이터
    let dataBase = WeatherDatabase()
    
    // getName 함수를 위한 모드
    enum whatShouldGet {
        case myViewList
        case allWeatherList
        case myHome
    }
    
    static var usingLocation: Bool = false
    
    // 처음엔 비어있음
    static var myWeatherViewList: [Weather] = []
    // 초기값은 전주로 했었음.
    static var myHome: Weather?
    
    // 불러온 모든 도시들의 날씨 데이터
    private static var allWeatherDataArray: [Weather] = [
        Weather(iDnum: 0 ,name: "서울", description: .clear, currentTemperature: "10°C", currentHumidity: "77 %", maxTemperature: "29°C", minTemperature: "22°C"),
        Weather(iDnum: 1 ,name: "대전", description: .rain, currentTemperature: "11°C", currentHumidity: "70 %", maxTemperature: "29°C", minTemperature: "22°C"),
        Weather(iDnum: 2 ,name: "대구", description: .snow, currentTemperature: "13°C", currentHumidity: "68 %", maxTemperature: "29°C", minTemperature: "22°C"),
        Weather(iDnum: 3 ,name: "부산", description: .clear, currentTemperature: "14°C", currentHumidity: "71 %", maxTemperature: "29°C", minTemperature: "22°C"),
        Weather(isMyList: false,iDnum: 4 ,isDay: false, name: "전주", description: .rain, currentTemperature: "12°C", currentHumidity: "79 %", maxTemperature: "20°C", minTemperature: "5°C"),
//        Weather(iDnum: 5 ,name: "일산", description: .clear, currentTemperature: "11°C", currentHumidity: "77 %", maxTemperature: "29°C", minTemperature: "7°C"),
//        Weather(iDnum: 6 ,name: "평택", description: .fog, currentTemperature: "12°C", currentHumidity: "69 %", maxTemperature: "29°C", minTemperature: "6°C"),
//        Weather(iDnum: 7 ,name: "과천", description: .cloud, currentTemperature: "9°C", currentHumidity: "73 %", maxTemperature: "19°C", minTemperature: "5°C"),
//        Weather(iDnum: 8 ,name: "고양", description: .clear, currentTemperature: "11°C", currentHumidity: "75 %", maxTemperature: "29°C", minTemperature: "9°C"),
//        Weather(iDnum: 9 ,name: "김포", description: .rain, currentTemperature: "10°C", currentHumidity: "67 %", maxTemperature: "29°C", minTemperature: "8°C"),
//        Weather(iDnum: 10 ,name: "춘천", description: .rain, currentTemperature: "13°C", currentHumidity: "70 %", maxTemperature: "29°C", minTemperature: "6°C"),
//        Weather(iDnum: 11 ,name: "안양", description: .rain, currentTemperature: "11°C", currentHumidity: "66 %", maxTemperature: "29°C", minTemperature: "9°C"),
//        Weather(iDnum: 12 ,name: "충주", description: .rain, currentTemperature: "11°C", currentHumidity: "75 %", maxTemperature: "29°C", minTemperature: "5°C"),
//        Weather(iDnum: 13 ,name: "수원", description: .rain, currentTemperature: "9°C", currentHumidity: "69 %", maxTemperature: "19°C", minTemperature: "5°C"),
//        Weather(iDnum: 14 ,name: "안산", description: .rain, currentTemperature: "11°C", currentHumidity: "67 %", maxTemperature: "29°C", minTemperature: "6°C"),
//        Weather(iDnum: 15 ,name: "용인", description: .rain, currentTemperature: "10°C", currentHumidity: "74 %", maxTemperature: "29°C", minTemperature: "7°C"),
//        Weather(iDnum: 16 ,name: "제주도", description: .rain, currentTemperature: "14°C", currentHumidity: "69 %", maxTemperature: "19°C", minTemperature: "13°C"),
//        Weather(iDnum: 17 ,name: "브리즈번", description: .clear, currentTemperature: "18°C", currentHumidity: "61 %", maxTemperature: "25°C", minTemperature: "16°C"),
//        Weather(iDnum: 18 ,name: "캔버라", description: .cloud, currentTemperature: "11°C", currentHumidity: "84 %", maxTemperature: "20°C", minTemperature: "8°C"),
//        Weather(iDnum: 19 ,name: "맬버른", description: .cloud, currentTemperature: "15°C", currentHumidity: "76 %", maxTemperature: "19°C", minTemperature: "13°C"),
//        Weather(iDnum: 20 ,name: "뉴욕", description: .clear, currentTemperature: "13°C", currentHumidity: "67 %", maxTemperature: "21°C", minTemperature: "11°C"),
//        Weather(iDnum: 21 ,name: "라스베이거스", description: .clear, currentTemperature: "20°C", currentHumidity: "30 %", maxTemperature: "33°C", minTemperature: "18°C"),
//        Weather(iDnum: 22 ,name: "파리", description: .clear, currentTemperature: "15°C", currentHumidity: "56 %", maxTemperature: "17°C", minTemperature: "9°C"),
//        Weather(iDnum: 23 ,name: "런던", description: .cloud, currentTemperature: "16°C", currentHumidity: "50 %", maxTemperature: "16°C", minTemperature: "6°C"),
//        Weather(iDnum: 24 ,name: "마드리드", description: .clear, currentTemperature: "22°C", currentHumidity: "56%", maxTemperature: "23°C", minTemperature: "23°C"),
//        Weather(iDnum: 25 ,name: "로마", description: .cloud, currentTemperature: "27°C", currentHumidity: "47 %", maxTemperature: "27°C", minTemperature: "15°C"),
    ]
    
    
    
    
    func isMyLocationOn() -> Bool {
        return DataManager.usingLocation
    }
    
    func toggleMyLocationPermission(){
        DataManager.usingLocation.toggle()
    }
    
    // 데이터를 초기 베이스 데이터 상태로 리셋
    func reSetAllWeatherDataArray() {
        DataManager.allWeatherDataArray =  dataBase.getAllDataFromBase()
    }
    
    // 이름기준 데이터 지우기
    func removeWeatherDataArray(name: String){
        print(#function + "\(name) 삭제")
        var dataArray = DataManager.allWeatherDataArray
        var index = 0
        
        dataArray.forEach{
            if $0.name == name{
                dataArray.remove(at: index)
            }else{
                index += 1
            }
            DataManager.allWeatherDataArray = dataArray
        }
    }
    
    // 초기 화면에 표시될 지역 리스트에 넣기 or 빼기.
    func toggleWeatherToViewList(name:String) {
        print(#function+"-------------------- Add Start")
        print("리스트 배열 수 \(getAllWeatherList().count)")
        
        var index = 0
        getAllWeatherList().forEach{
            if $0.name == name {
                DataManager.allWeatherDataArray[index].isMyList.toggle()
                
            }else { index += 1 }
        }
        
        
        print("추가됨 -----------> \(DataManager.allWeatherDataArray[index].name)")
        setMyWeatherViewList()
        print(#function+"-------------------- Add DONE")
    }
    
    //유저가 선택한 특정도시들의 날씨 추출
    func setMyWeatherViewList() {
        print(#function + "-------------------- Start")
        
        // 초기화면에 출력될 지역들 선별
        DataManager.myWeatherViewList = DataManager.allWeatherDataArray.filter{ $0.isMyList }
        
        // 홈 지역을 맨 앞으로
        var myArr = DataManager.myWeatherViewList
        var index = 0
        if let home = DataManager.myHome {
            myArr.forEach{
                if $0.name == home.name {
                    myArr.swapAt(0,index)
                }
                index += 1
            }
        }
        let temp = myArr.map{$0.name}
        print("myWeatherViewList: \(temp)")
        DataManager.myWeatherViewList = myArr
        
        print(#function + "-------------------- DONE")
    }
    
    func getMySortedWeatherListView() -> [Weather]{
        
        let allList = getAllWeatherList()
        // MyList를 최상단에 올리기 위해 먼저 분리해주기
        var myList = allList.filter{$0.isMyList == true}
        
        // MyList안에 home을 등록해놨다면 home을 가장 위로올리기
        if let home = DataManager.myHome {
            var index = 0
            myList.forEach{
                if $0.name == home.name{
                    myList.swapAt(0, index)
                }else { index += 1 }
            }
        }
        
        // allList에서 MyList 항목들을 제거하기 ⚠️
        let exceptedAllList = removeIntersection(except: myList, from: allList)
        myList.append(contentsOf: exceptedAllList)
        
        return myList
    }
    
    // 겹치는 배열을 제거해주는 함수
    func removeIntersection(except arrA: [Weather], from arrB: [Weather]) -> [Weather] {
        let shouldExceptName: [String] = arrA.map{$0.name}
        var willExceptedArr = arrB
        var index = 0
        
        willExceptedArr.forEach{
            if shouldExceptName.contains($0.name) {
                willExceptedArr.remove(at: index)
            }else { index += 1 }
        }
        return willExceptedArr
    }
    
    // WeatherData ID Number에 따라서 정렬
    func sortById(notSortedArray: [Weather]) -> [Weather] {
        
        var index: Int
        var array: [Weather] = notSortedArray
        
        for i in 0 ..< notSortedArray.count {
            var min: Int = array[i].iDnum
            index = i
            
            for j in i + 1 ..< array.count {
                if (min > array[j].iDnum) {
                    min =  array[j].iDnum
                    index = j
                }
            }
            array.swapAt(i, index)
        }
        return array
    }
    
    func getNames(iWannaGet mode: whatShouldGet) -> [String]? {
        
        switch mode {
        case .myHome:
            if let myHome = DataManager.myHome?.name{
                return ["\(myHome)"]
            }else { return nil }
        case .allWeatherList:
            let nameArr = getAllWeatherList().map{$0.name}
            return nameArr
        case .myViewList:
            let nameArr = getMyWeatherViewList().map{$0.name}
            return nameArr
        }
    }
    
    
    func getMyWeatherViewList() -> [Weather] {
        return DataManager.myWeatherViewList
    }
    
    func getAllWeatherList() -> [Weather] {
        return DataManager.allWeatherDataArray
    }
}
