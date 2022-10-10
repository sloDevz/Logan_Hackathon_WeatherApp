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
        setupCollectionView()
        
    }
    
    // 화면이 출력될 때
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // 네비게이션바 없앰
        navigationController?.setNavigationBarHidden(true, animated: animated)
        
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
        
        detailCollectionView.delegate = self
        detailCollectionView.dataSource = self
        detailCollectionView.backgroundColor = .clear
        // 컬렉션뷰의 스크롤 방향 설정
        flowLayout.scrollDirection = .horizontal
        
        
        //        let screenHeight: CGFloat = self.view.frame.height
        //        let screenWidth: CGFloat = self.view.frame.width
        //        flowLayout.itemSize = CGSize(width: screenWidth, height: screenHeight)
        // 아이템 사이 간격 설정
        flowLayout.minimumInteritemSpacing = 20
        // 아이템 위아래 사이 간격 설정
        flowLayout.minimumLineSpacing = 10
        
        //컬렉션뷰의 속성에 할당
        detailCollectionView.collectionViewLayout = flowLayout
        
        
    }
    
    @IBAction func locationButtonTapped(_ sender: UIButton) {
        print(#function)
        
        let gpsstatus = CLLocationManager.authorizationStatus()
        if gpsstatus == CLAuthorizationStatus.denied || gpsstatus == CLAuthorizationStatus.restricted || gpsstatus == CLAuthorizationStatus.notDetermined {
            print("위도 경도 가져오기 - 권한 거부함")
            
            let alert = UIAlertController(title: "위치정보가 필요합니다.", message: "사용자의 위치정보를 사용하기 위해서는 위치정보사용 권한이 필요합니다. 권한설정을 위해 설정창으로 이동하시겠습니까?", preferredStyle: UIAlertController.Style.alert)
            let yes = UIAlertAction(title: "예", style: UIAlertAction.Style.default){_ in
                UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
            }
            let no = UIAlertAction(title: "아니오", style: UIAlertAction.Style.default)
            
            alert.addAction(yes)
            alert.addAction(no)
            self.present(alert, animated: true)
        }
    }
    
    
    
    @IBAction func addButtonTapped(_ sender: UIButton) {
        self.performSegue(withIdentifier: "toListVC", sender: self)
        print(#function)
    }
    
    @IBAction func configureTapped(_ sender: UIButton) {
        print(#function)
        performSegue(withIdentifier: "toConfigVC", sender: self)
    }
    
    
    @IBAction func likeButtonTapped(_ sender: UIButton) {
        print(#function)
        
    }
    
    
    
    
    //MARK: - Segue prepare func
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //print(#function)
        if segue.identifier == "toListVC" {
            let listVC = segue.destination as! ListViewController
            listVC.weatherDataManager = self.weatherDataManager
            listVC.dataArray = weatherDataManager.getAllWeatherList()
        }
        if segue.identifier == "toConfigVC" {
            let configVC = segue.destination as! ConfigVC
            
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
        let myList = weatherDataManager.getMyWeatherViewList()
        
        cell.regionNameLabel.text = myList[indexPath.item].name
        cell.currentTemperatureLabel.text = myList[indexPath.item].currentTemperature
        cell.weatherIcon.image = myList[indexPath.item].icon
        cell.weatherDescriptionLabel.text = myList[indexPath.item].description.rawValue
        cell.currentHumidityLabel.text = myList[indexPath.item].currentHumidity
        cell.maxTemperatureLabel.text = myList[indexPath.item].maxTemperature
        cell.minTemperatureLabel.text = myList[indexPath.item].minTemperature
        cell.idNum = myList[indexPath.item].iDnum
        
        // likes라면 버튼모양 바꿈
        if myList[indexPath.item].iDnum == DataManager.myHome {
            cell.likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        }else {
            cell.likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
        }
        
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

extension DetailCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.bounds.size
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return .zero
    }
}
