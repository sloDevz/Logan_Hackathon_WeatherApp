//
//  WeatherCell.swift
//  Logan_Hackathon_WeatherApp
//
//  Created by DONGWOOK SEO on 2022/10/06.
//

import UIKit

class WeatherCell: UITableViewCell {
    
    var myList: [String]!
    var isMyCity: Bool?
    var myHome: Weather?
    var myName: String!
    
    @IBOutlet weak var regionNameLabel: UILabel!
    
    @IBOutlet weak var weatherIcon: UIImageView!
    
    @IBOutlet weak var selectButton: UIButton!
    
    @IBOutlet weak var homeButton: UIButton!
    
    
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
        if myList.contains(myName){
            print("Cell MyList ::",myList)
            selectButton.isHidden = false
            homeButton.isHidden = false
            
            if isMyCity! {
                selectButton.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
            }else {
                selectButton.setImage(UIImage(systemName: "checkmark.circle"), for: .normal)
            }
            
            
            if let myHomeName = myHome?.name {
                if myHomeName == myName {
                    homeButton.isHidden = false
                    homeButton.setImage(UIImage(systemName: "house.fill"), for: .normal)
                }else{homeButton.isHidden = true}
                
            }else {
                homeButton.isHidden = true
            }
            
        }else {
            selectButton.isHidden = true
            homeButton.isHidden = true
        }
    }

}
