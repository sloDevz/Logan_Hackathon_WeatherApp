//
//  WeatherCell.swift
//  Logan_Hackathon_WeatherApp
//
//  Created by DONGWOOK SEO on 2022/10/06.
//

import UIKit

class WeatherCell: UITableViewCell {
    
    
    
    @IBOutlet weak var dataLabel: UILabel!
    @IBOutlet weak var homeIcon: UIImageView!
    @IBOutlet weak var heartIcon: UIImageView!
    
    
    var data: Weather?
    var dataIndex: Int?
    
    var myList: [String]!
    var isMyCity: Bool?
    var myHome: Weather?
    var myName: String!
    
//    @IBOutlet weak var regionNameLabel: UILabel!

    @IBOutlet weak var dataIcon: UIImageView!
    
//    @IBOutlet weak var likeButton: UIButton!
//
//    @IBOutlet weak var homeButton: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
//        print("Cell 정보::::", data?.name, isMyCity)
        setUI()
        
        // Configure the view for the selected state
    }
    
    func setUI() {
        
        switch dataIndex {
        case 0:
            dataIcon.image = data!.icon
            dataLabel.text = data!.name
            
            setIcon()
        case 1:
            dataIcon.image = UIImage(systemName: "thermometer.medium")
            dataLabel.text = data!.currentTemperature
            homeIcon.isHidden = true
            heartIcon.isHidden = true
            self.backgroundColor = UIColor(red: 215/255, green: 239/255, blue: 239/255, alpha: 0.3)
        case 2:
            dataIcon.image = UIImage(systemName: "drop.fill")
            dataLabel.text = data!.currentHumidity
            homeIcon.isHidden = true
            heartIcon.isHidden = true
            self.backgroundColor = UIColor(red: 215/255, green: 239/255, blue: 239/255, alpha: 0.5)
        case 3:
            dataIcon.image = UIImage(systemName: "arrowtriangle.up.fill")
            dataLabel.text = data!.maxTemperature
            homeIcon.isHidden = true
            heartIcon.isHidden = true
            self.backgroundColor = UIColor(red: 215/255, green: 239/255, blue: 239/255, alpha: 0.7)
        case 4:
            dataIcon.image = UIImage(systemName: "arrowtriangle.down.fill")
            dataLabel.text = data!.minTemperature
            homeIcon.isHidden = true
            heartIcon.isHidden = true
            self.backgroundColor = UIColor(red: 215/255, green: 239/255, blue: 239/255, alpha: 1)
            
        default:
            return
        }
        
        
        
    }
    
    
    func setIcon() {
        if myList.contains(myName){
            self.backgroundColor = UIColor.white
            dataIcon.isHidden = false
            heartIcon.isHidden = false
            homeIcon.isHidden = false

            if isMyCity! {
                heartIcon.isHidden = false
            }else {
                heartIcon.isHidden = true
            }


            if let myHomeName = myHome?.name {
                if myHomeName == myName {
                    homeIcon.isHidden = false
                    homeIcon.image = UIImage(systemName: "house.fill")
                }else{ homeIcon.isHidden = true }

            }else {
                homeIcon.isHidden = true
            }

        }else {
            dataIcon.isHidden = true
            heartIcon.isHidden = true
            homeIcon.isHidden = true
            self.backgroundColor = UIColor.systemGray5
        }
    }

}
