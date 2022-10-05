//
//  ViewController.swift
//  Logan_Hackathon_WeatherApp
//
//  Created by DONGWOOK SEO on 2022/10/05.
//

import UIKit
import MapKit

class ViewController: UIViewController {
    var weatherDataManager = DataManager()
    
    @IBOutlet weak var regionTableView: UITableView!
    
    // CLLocationManager 객체 생성
    let locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()

        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        
        
        regionTableView.dataSource = self
        regionTableView.rowHeight = 120
        regionTableView.delegate = self
        
        weatherDataManager.makeMovieData()
    }
    
    
    
    
}

extension ViewController : CLLocationManagerDelegate {
    
    func requestGPSPermission(){
          switch CLLocationManager.authorizationStatus() {
          case .authorizedAlways, .authorizedWhenInUse:
              print("GPS: 권한 있음")
          case .restricted, .notDetermined:
              print("GPS: 아직 선택하지 않음")
          case .denied:
               print("GPS: 권한 없음")
          default:
              print("GPS: Default")
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
        
        
        cell.selectionStyle = .none
        
        return cell
    }
}

extension ViewController : UITableViewDelegate {
    
}
