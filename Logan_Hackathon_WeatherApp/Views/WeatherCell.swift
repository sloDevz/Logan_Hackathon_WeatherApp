//
//  WeatherCell.swift
//  Logan_Hackathon_WeatherApp
//
//  Created by DONGWOOK SEO on 2022/10/06.
//

import UIKit

class WeatherCell: UITableViewCell {
    

    
    var weatherDataManager: DataManager?
    
    @IBOutlet weak var regionNameLabel: UILabel!
    
    @IBOutlet weak var weatherIcon: UIImageView!
    
    @IBOutlet weak var selectButton: UIButton!
    
    @IBOutlet weak var likeButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setUI()
    }
    
    func setUI() {

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    @IBAction func likeButtonTapped(_ sender: UIButton) {
        
    }
    
    @IBAction func selectButtonTapped(_ sender: UIButton) {
//        print("selectButton Tapped: \(regionNameLabel.text!)")
        
    }
    
    
    
}
