//
//  DetailViewController.swift
//  Logan_Hackathon_WeatherApp
//
//  Created by DONGWOOK SEO on 2022/10/06.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var regionNameLabel: UILabel!
    @IBOutlet weak var weatherDescriptionLabel: UILabel!
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var currentTemperatureLabel: UILabel!
    @IBOutlet weak var currentHumidityLabel: UILabel!
    @IBOutlet weak var maxTemperatureLabel: UILabel!
    @IBOutlet weak var minTemperatureLabel: UILabel!
    
    
    
    
    var selectedCity: [Weather]?

    override func viewDidLoad() {
        super.viewDidLoad()
        setUI(weatherData: selectedCity!)
    }
    
    func setUI(weatherData: [Weather]){
        let index = 0
        print("디테일뷰: \(weatherData)")
        regionNameLabel.text = weatherData[index].name
        weatherDescriptionLabel.text = weatherData[index].description.rawValue
        weatherIcon.image = weatherData[index].icon
        currentTemperatureLabel.text = weatherData[index].currentTemperature
        currentHumidityLabel.text = weatherData[index].currentHumidity
        maxTemperatureLabel.text = weatherData[index].maxTemperature
        minTemperatureLabel.text = weatherData[index].minTemperature
    }
    
}



