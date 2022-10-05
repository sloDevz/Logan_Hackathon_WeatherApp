//
//  File.swift
//  Logan_Hackathon_WeatherApp
//
//  Created by DONGWOOK SEO on 2022/10/06.
//

import UIKit

struct Weather {
    
    enum WeatherDescription {
        case clear
        case clouds
        case mist
        case rain
    }
    
    var name: String
    var icon: UIImage
    var description: WeatherDescription
    var currentDegree: Double
    var currentTemperature: Double
    var maxTemperature: Double
    var minTemperature: Double
}
