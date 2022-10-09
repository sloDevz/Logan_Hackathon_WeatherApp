//
//  File.swift
//  Logan_Hackathon_WeatherApp
//
//  Created by DONGWOOK SEO on 2022/10/06.
//

import UIKit

struct Weather {
    
    enum WeatherDescription:String {
        case clear = "맑음"
        case cloud = "구름낌"
        case fog = "안개"
        case rain = "비"
        case snow = "눈"
    }
    
    var isMyList: Bool = false
    var name: String
    var icon: UIImage {
        get{
            switch description {
            case .clear:
                return UIImage(systemName: "sun.min")!
            case .cloud:
                return UIImage(systemName: "cloud")!
            case .fog:
                return UIImage(systemName: "cloud.fog")!
            case .rain:
                return UIImage(systemName: "cloud.rain")!
            case .snow:
                return UIImage(systemName: "cloud.snow")!
            }
        }
    }
    var description: WeatherDescription
    var currentTemperature: String
    var currentHumidity: String
    var maxTemperature: String
    var minTemperature: String
    
    mutating func toggleMyList(){
        self.isMyList.toggle()
    }
}
