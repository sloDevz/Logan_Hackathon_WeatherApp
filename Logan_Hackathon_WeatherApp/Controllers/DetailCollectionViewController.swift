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
    
    
    
    let dataManager = DataManager()
    let flowLayout = UICollectionViewFlowLayout()
    
    var myList:[String] = [] {
        didSet {
            print("myList :::::",oldValue, " ===>", myList)
        }
    }
    
    var currentPageIndex:Int = 0

    // CLLocationManager 객체 생성
    let locationManager = CLLocationManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        
        
    }
    
    // 화면이 출력될 때
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        detailCollectionView.reloadData()
        
    }
    
    func setUI(){
        
        myList = dataManager.getAllMySortedWeatherListView().map{$0.name}
        locationManager.desiredAccuracy = kCLLocationAccuracyBest // 정확한 위치받기
        locationManager.delegate = self
        self.locationManager.requestWhenInUseAuthorization()
        
        setupCollectionView()
        dataManager.setMyWeatherViewList()
        
    }
    
    
    func setupCollectionView() {
        //컬렉션뷰의 레이아웃을 담당하는 객체
        
        detailCollectionView.delegate = self
        detailCollectionView.dataSource = self
        detailCollectionView.backgroundColor = .clear
        // 컬렉션뷰의 스크롤 방향 설정
        flowLayout.scrollDirection = .horizontal
        
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
        } else {
            showToast(message: "이미 위치정보를 사용중입니다.", font: UIFont.systemFont(ofSize: 17, weight: .heavy), width: 300, height: 40, boxColor: UIColor.red)
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
    
    
    
    @IBAction func homeButtonTapped(_ sender: UIButton) {
        print(#function)
        
        let currentPageItem = dataManager.getMyWeatherViewList()[currentPageIndex]
        
        guard let myHomeName = DataManager.myHome?.name else {
            // myHome이 등록돼 있지 않은 상태라면.
            DataManager.myHome = currentPageItem
            dataManager.setMyWeatherViewList()
            showToast(message: "\(currentPageItem.name) : 집으로 등록되었습니다.", font: UIFont.systemFont(ofSize: 17, weight: .heavy), width: 300, height: 35, boxColor: UIColor(red: 0.0588, green: 0.6, blue: 0, alpha: 1.0))
            
            dataManager.setMyWeatherViewList()
            detailCollectionView.reloadData()
            
            return
        }
        
        // myHome이 있는 상황.
        if myHomeName != currentPageItem.name {
            dataManager.setMyHome(myHome: currentPageItem)
            dataManager.setMyWeatherViewList()
            showToast(message: "\(currentPageItem.name) : 집으로 등록되었습니다.", font: UIFont.systemFont(ofSize: 17, weight: .heavy), width: 300, height: 35, boxColor: UIColor(red: 0.0588, green: 0.6, blue: 0, alpha: 1.0))
        } else {
            dataManager.setMyHome(myHome: nil)
            showToast(message: "집 등록이 해제되었습니다.", font: UIFont.systemFont(ofSize: 17,weight: .heavy), width: 300, height: 35, boxColor: UIColor.blue)
        }
        
        
        
        dataManager.setMyWeatherViewList()
        detailCollectionView.reloadData()
    }
    
    // 이부분 호출이 느린이유를 알고, 해결할 것. ⭐️⭐️⭐️⭐️
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        for cell in detailCollectionView.visibleCells {
            let indexPath = detailCollectionView.indexPath(for: cell)
            currentPageIndex = indexPath!.row
            print("VisibleCell ====################")
            print(indexPath!.row)
            print("--------------------------------\n")
        }
    }
    
    
    func popAlertSomeSec(title: String, message: String, interval: Double){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        self.present(alert, animated: true, completion: nil)
        
        Timer.scheduledTimer(withTimeInterval: interval, repeats: false, block: { _ in alert.dismiss(animated: true, completion: nil)} )
    }
    
    
    func showToast(message : String, font: UIFont, width: CGFloat, height: CGFloat, boxColor: UIColor) {
        // 메세지창 위치지정
        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.width/2 - width/2, y: self.view.frame.size.height-100, width: width, height: height))
        toastLabel.backgroundColor = boxColor.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.font = font
        toastLabel.textAlignment = .center;
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 1.8, delay: 1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
    
    
    //MARK: - Segue prepare func
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //print(#function)
        if segue.identifier == "toListVC" {
            let listVC = segue.destination as! ListViewController
            listVC.filterNames = myList
        }
        
//        if segue.identifier == "toConfigVC" {
//            let configVC = segue.destination as! ConfigVC
//
//        }
    }
    
    
}

//MARK: - Extensions below




extension DetailCollectionViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    //컬렉션뷰 몇개 만들지?
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return dataManager.getMyWeatherViewList().count
    }
    
    // 각 콜렉션뷰 Cell에 대한 설정
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DetailViewCell", for: indexPath) as! CollectionViewCell
        let myList = dataManager.getMyWeatherViewList()
        
        cell.regionNameLabel.text = myList[indexPath.item].name
        cell.currentTemperatureLabel.text = myList[indexPath.item].currentTemperature
        cell.weatherIcon.image = myList[indexPath.item].icon
        cell.weatherDescriptionLabel.text = myList[indexPath.item].description.rawValue
        cell.currentHumidityLabel.text = myList[indexPath.item].currentHumidity
        cell.maxTemperatureLabel.text = myList[indexPath.item].maxTemperature
        cell.minTemperatureLabel.text = myList[indexPath.item].minTemperature
        
        
        // 유저가 마이홈을 등록했는지 확인후 cell 형성
        if let myHomeName = dataManager.getMyHome()?.name {
            cell.homeButton.setImage(UIImage(systemName: "house"), for: .normal)
            
            if myList[indexPath.row].name == myHomeName {
                cell.homeButton.setImage(UIImage(systemName: "house.fill"), for: .normal)
            }
        }else {
            cell.homeButton.setImage(UIImage(systemName: "house"), for: .normal)
        }
        print("Collection View Cell 구성 완료")
        
        
        return cell
    }
}

//MARK: - Get permission to access Location
extension DetailCollectionViewController : CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus){
        
        switch status {
        case .restricted, .notDetermined:
            print("사용자: 위치 사용 여부 체크중")
        case .authorizedAlways, .authorizedWhenInUse: // 허용
            dataManager.toggleMyLocationPermission()
            print("사용자: 위치 허용")
            dataManager.toggleWeatherToViewList(name: dataManager.getAllMySortedWeatherListView().randomElement()!.name)
            self.locationManager.startUpdatingLocation()
            detailCollectionView.reloadData()
            
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
