//
//  ViewController.swift
//  Logan_Hackathon_WeatherApp
//
//  Created by DONGWOOK SEO on 2022/10/05.
//

import UIKit
import CoreLocation


final class ViewController: UIViewController {
    let weatherDataManager = DataManager()
    
    @IBOutlet weak var regionTableView: UITableView!
    
    // CLLocationManager 객체 생성
    let locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        
        
        regionTableView.dataSource = self
        regionTableView.rowHeight = 80
        regionTableView.delegate = self
        
        weatherDataManager.makeWeatherData()
    }
    
    
    
    
}

extension ViewController : CLLocationManagerDelegate {
    func setup() {
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBest // 정확한 위치받기
        locationManager.delegate = self
        self.locationManager.requestWhenInUseAuthorization()
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus){
        
        switch status {
        case .restricted, .notDetermined:
            print("사용자: 위치 사용 여부 체크중")
        case .authorizedAlways, .authorizedWhenInUse:
            print("사용자: 위치 허용")
            self.locationManager.startUpdatingLocation()
            // DetailView 로 넘어가는 세그웨이 호출
            self.performSegue(withIdentifier: "toDetailVC", sender: self)
        case .denied: //허용거부
            print("사용자: 위치사용 거부")
        default:
            print("GPS: default")
        }
      }

}



extension ViewController : UITableViewDataSource {
    //컨텐츠 몇개?
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherDataManager.getWeatherData().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // dequeueReusableCell의 리턴값이 UITableViewCell 이기 때문에 MovieCell 타입으로 다시 캐스팅 해줘야함.
        let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherCell", for: indexPath) as! WeatherCell
        
        let array = weatherDataManager.getWeatherData()
        let weather = array[indexPath.row] //이걸로 코드 줄여도 됨
        
        cell.regionNameLabel.text = weather.name
        cell.weatherIcon.image = weather.icon
        cell.currentTemperatureLabel.text = weather.currentTemperature
        cell.selectionStyle = .none
        
        return cell
    }
}

extension ViewController : UITableViewDelegate {
    // 셀이 선택됐을때에 대한 반응
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 세그웨이를 사용할땐 항상 사용. ( sender는 정보전달 )
        
        // 선택된 셀의 요소를 weatherDataOut 배열중 가장 첫번째로 옮기기.
        weatherDataManager.weatherDataList.swapAt(0, indexPath.row)
//        print("뷰컨: \(weatherDataManager.weatherDataList)")
        
        performSegue(withIdentifier: "toDetailVC", sender: indexPath)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //print(#function)
        if segue.identifier == "toDetailVC" {
            let detailVC = segue.destination as! DetailCollectionViewController
            detailVC.selectedCity = weatherDataManager.weatherDataList
            //thirdVC.mainLabel.text = "안녕하세요"    // 에러발생 (스토리보드 객체가 나중에 생김)
        }
    }
}
