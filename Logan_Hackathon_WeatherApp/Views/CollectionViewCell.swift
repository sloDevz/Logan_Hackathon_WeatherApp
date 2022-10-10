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
    
    @IBOutlet weak var likeButton: UIButton!
    
    
    var idNum: Int!
    
    @IBAction func likeButtonTapped(_ sender: UIButton) {
        if DataManager.myHome != idNum {
            DataManager.myHome = idNum
            likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        } else {
            DataManager.myHome = nil
            likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
        }
    }
    
    
}
