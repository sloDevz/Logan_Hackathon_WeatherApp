//
//  WeatherCell.swift
//  Logan_Hackathon_WeatherApp
//
//  Created by DONGWOOK SEO on 2022/10/06.
//

import UIKit

class WeatherCell: UITableViewCell {
    
    var isMyList: Bool?
    var myHome: Weather?
    var myName: String!
    
    @IBOutlet weak var regionNameLabel: UILabel!
    
    @IBOutlet weak var weatherIcon: UIImageView!
    
    @IBOutlet weak var selectButton: UIButton!
    
    @IBOutlet weak var likeButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        setUI()
        
        // Configure the view for the selected state
    }
    
    func setUI() {
        if isMyList! {
            selectButton.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
        }else {
            selectButton.setImage(UIImage(systemName: "checkmark.circle"), for: .normal)
        }
        
        if myHome!.name == myName {
//            print("############################ myHomeID: \(myHome) // myID: \(myId)")
            likeButton.isHidden = false
            likeButton.setImage(UIImage(systemName: "house.fill"), for: .normal)
        }else {
//            print("myHomeID: \(myHome) \n myID: \(myId)")
            likeButton.isHidden = true
        }
        
        
        
    }

    
    @IBAction func likeButtonTapped(_ sender: UIButton) {
        
    }
    
    @IBAction func selectButtonTapped(_ sender: UIButton) {
//        print("selectButton Tapped: \(regionNameLabel.text!)")
        
    }
    
    
    
}
