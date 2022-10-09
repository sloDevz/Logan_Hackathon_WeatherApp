//
//  DetailCollectionViewController.swift
//  Logan_Hackathon_WeatherApp
//
//  Created by DONGWOOK SEO on 2022/10/08.
//

import UIKit
import CoreLocation

class DetailCollectionViewController: UIViewController {
    
    @IBOutlet weak var detailCollectionView: UICollectionView!
    
    let weatherDataManager = DataManager()
    let flowLayout = UICollectionViewFlowLayout()
    
    // CLLocationManager 객체 생성
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        detailCollectionView.delegate = self
        setupCollectionView()
        
    }
    
    // 화면이 출력될 때
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // 네비게이션바 없앰
        navigationController?.setNavigationBarHidden(true, animated: animated)
        weatherDataManager.setMyWeatherViewList()
        detailCollectionView.reloadData()
        
    }

    
    //화면이 사라지고 다음으로 넘어갈때
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // 네비게이션바 다시 표시
        navigationController?.setNavigationBarHidden(false, animated: animated)
        
    }
    
    func setUI(){
        weatherDataManager.setMyWeatherViewList()
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBest // 정확한 위치받기
        locationManager.delegate = self
        self.locationManager.requestWhenInUseAuthorization()
    }
    
    func setupCollectionView() {
        //컬렉션뷰의 레이아웃을 담당하는 객체
        
        detailCollectionView.dataSource = self
        detailCollectionView.backgroundColor = .clear
        // 컬렉션뷰의 스크롤 방향 설정
        flowLayout.scrollDirection = .horizontal
        
        
        let screenHeight: CGFloat = self.view.frame.height
        let screenWidth: CGFloat = self.view.frame.width
        flowLayout.itemSize = CGSize(width: screenWidth, height: screenHeight)
        // 아이템 사이 간격 설정
        flowLayout.minimumInteritemSpacing = 20
        // 아이템 위아래 사이 간격 설정
        flowLayout.minimumLineSpacing = 10
        
        //컬렉션뷰의 속성에 할당
        detailCollectionView.collectionViewLayout = flowLayout
        
        
    }
    
    @IBAction func locationButtonTapped(_ sender: UIButton) {
        print("ReLocation ButtonTapped")
    }
    
    @IBAction func addButtonTapped(_ sender: UIButton) {
        self.performSegue(withIdentifier: "toListVC", sender: self)
        print("AddButton Tapped")
    }
    
    @IBAction func configureTapped(_ sender: UIButton) {
        print("Configure Button Tapped")
        self.performSegue(withIdentifier: "toConfigureVC", sender: self)
    }
    
    //MARK: - Segue prepare func
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //print(#function)
        if segue.identifier == "toListVC" {
            let listVC = segue.destination as! ListViewController
            listVC.weatherDataManager = self.weatherDataManager
            listVC.myCityList = weatherDataManager.getMyWeatherViewList()
            listVC.allCityList = weatherDataManager.getAllWeatherList()
        }
        if segue.identifier == "toConfigureVC" {
            
        }
    }
    
    
}

//MARK: - Extensions below
extension DetailCollectionViewController: UICollectionViewDelegate{
    
}

extension DetailCollectionViewController: UICollectionViewDataSource {
    
    //컬렉션뷰 몇개 만들지?
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return weatherDataManager.getMyWeatherViewList().count
    }
    
    // 각 콜렉션뷰 Cell에 대한 설정
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DetailViewCell", for: indexPath) as! CollectionViewCell
        let myCityList = weatherDataManager.getMyWeatherViewList()
        
        cell.regionNameLabel.text = myCityList[indexPath.item].name
        cell.currentTemperatureLabel.text = myCityList[indexPath.item].currentTemperature
        cell.weatherIcon.image = myCityList[indexPath.item].icon
        cell.weatherDescriptionLabel.text = myCityList[indexPath.item].description.rawValue
        cell.currentHumidityLabel.text = myCityList[indexPath.item].currentHumidity
        cell.maxTemperatureLabel.text = myCityList[indexPath.item].maxTemperature
        cell.minTemperatureLabel.text = myCityList[indexPath.item].minTemperature
        
        return cell
    }
}

//MARK: - Get permission to access Location
extension DetailCollectionViewController : CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus){
        
        switch status {
        case .restricted, .notDetermined:
            print("사용자: 위치 사용 여부 체크중")
        case .authorizedAlways, .authorizedWhenInUse:
            print("사용자: 위치 허용")
            self.locationManager.startUpdatingLocation()
        case .denied: //허용거부
            self.performSegue(withIdentifier: "toListVC", sender: self)
            print("사용자: 위치사용 거부")
        default:
            print("GPS: default")
        }
      }

}

