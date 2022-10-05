//
//  WeatherCell.swift
//  Logan_Hackathon_WeatherApp
//
//  Created by DONGWOOK SEO on 2022/10/06.
//

import UIKit

class WeatherCell: UITableViewCell {

    @IBOutlet weak var regionNameLabel: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
