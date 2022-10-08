//
//  CollectionViewCell.swift
//  Logan_Hackathon_WeatherApp
//
//  Created by DONGWOOK SEO on 2022/10/08.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
//    required init?(coder: NSCoder) {
//      fatalError()
//    }
//    override init(frame: CGRect) {
//      super.init(frame: frame)
//
//        self.backgroundColor = .blue
//    }
    
    @IBOutlet weak var regionNameLabel: UILabel!
    
    @IBOutlet weak var weatherDescriptionLabel: UILabel!
    
    @IBOutlet weak var weatherIcon: UIImageView!
    
    @IBOutlet weak var currentTemperatureLabel: UILabel!
    
    
    
    
}
