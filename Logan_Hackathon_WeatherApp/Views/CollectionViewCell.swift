//
//  CollectionViewCell.swift
//  Logan_Hackathon_WeatherApp
//
//  Created by DONGWOOK SEO on 2022/10/08.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var regionNameLabel: UILabel!
    
    @IBOutlet weak var weatherDescriptionLabel: UILabel!
    
    @IBOutlet weak var weatherIcon: UIImageView!
    
    @IBOutlet weak var currentTemperatureLabel: UILabel!
    
    @IBOutlet weak var currentHumidityLabel: UILabel!
    
    @IBOutlet weak var maxTemperatureLabel: UILabel!
    
    @IBOutlet weak var minTemperatureLabel: UILabel!
    
}
