//
//  ViewController.swift
//  Logan_Hackathon_WeatherApp
//
//  Created by DONGWOOK SEO on 2022/10/05.
//

import UIKit
import CoreLocation


final class ListViewController: UIViewController {
    // 데이터 관련
    var weatherDataManager: DataManager?
    var allCityList: [Weather]?
    var myCityList: [Weather]?
    
    
    
    
    @IBOutlet weak var listTableView: UITableView!
    


    override func viewDidLoad() {
        super.viewDidLoad()
        
        listTableView.dataSource = self
        listTableView.rowHeight = 80
        listTableView.delegate = self
        
    }

}




//MARK: - Extensions below
extension ListViewController : UITableViewDataSource {
    //컨텐츠 몇개?
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allCityList!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // dequeueReusableCell의 리턴값이 UITableViewCell 이기 때문에 MovieCell 타입으로 다시 캐스팅 해줘야함.
        let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherCell", for: indexPath) as! WeatherCell
        
        let array = allCityList
        let weather = array![indexPath.row] //이걸로 코드 줄여도 됨
        
        cell.weatherDataManager = weatherDataManager.self
        cell.regionNameLabel.text = weather.name
        cell.weatherIcon.image = weather.icon
        cell.selectionStyle = .none
        
        return cell
    }
}

extension ListViewController : UITableViewDelegate {
    // 셀이 선택됐을때에 대한 반응
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 세그웨이를 사용할땐 항상 사용. ( sender는 정보전달 )
        
        // 선택된 도시의 이름(String)
        var selectedRegion = allCityList![indexPath.row]
        print("\(selectedRegion.name) has selected.")
        print("List: \(selectedRegion.name) is \(selectedRegion.isMyList)")
        weatherDataManager!.addMyCityList(&selectedRegion)
        print("List \(selectedRegion.name) is \(selectedRegion.isMyList)\n============")
        
        // 선택된 셀의 요소를 myCityList 배열중 가장 첫번째로 옮기기.
//        weatherDataManager.myWeatherDataList.swapAt(0, indexPath.row)
        
    }
    

}