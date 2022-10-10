//
//  ConfigVC.swift
//  Logan_Hackathon_WeatherApp
//
//  Created by DONGWOOK SEO on 2022/10/10.
//

import UIKit

class ConfigVC: UIViewController {
    
    @IBOutlet weak var configTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configTableView.delegate = self
        configTableView.delegate = self
        configTableView.rowHeight = 80
    }
    
}

extension ConfigVC: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // dequeueReusableCell의 리턴값이 UITableViewCell 이기 때문에 MovieCell 타입으로 다시 캐스팅 해줘야함.
//        let cell = tableView.dequeueReusableCell(withIdentifier: "ConfigCell", for: indexPath) as! ConfigCell
        
        
//        cell.configTextLabel.text = "About"
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

