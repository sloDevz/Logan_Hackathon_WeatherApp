//
//  ViewController.swift
//  Logan_Hackathon_WeatherApp
//
//  Created by DONGWOOK SEO on 2022/10/05.
//

import UIKit
import CoreLocation


class ListViewController: UIViewController {
    
    
    
    
    @IBOutlet weak var listTableView: UITableView!
    
    let searchController = UISearchController()
    
    var weatherDataManager: DataManager?
    
    var filteredData: [Weather]?
    var filteredName: [String]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUp()
        
    }
    
    func setUp() {
        
        navigationItem.searchController = searchController
        searchController.searchBar.delegate = self
        searchController.searchResultsUpdater = self
        
        listTableView.dataSource = self
        listTableView.rowHeight = 80
        listTableView.delegate = self
    }
    
}

//MARK: - Extensions below

extension ListViewController: UISearchResultsUpdating, UISearchBarDelegate {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        print(text)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        filteredData = []
        
        let index = navigationController!.viewControllers.count - 2
        let vc = navigationController?.viewControllers[index] as! DetailCollectionViewController
        vc.weatherDataManager.setMyWeatherViewList()
        
        if searchText == "" {
            filteredName = nil
            filteredData = vc.weatherDataManager.getMySortedWeatherListView()
        }
        else {
            for weatherData in vc.weatherDataManager.getMySortedWeatherListView() {
                if weatherData.name.hasPrefix(searchText) {
                    filteredData?.append(weatherData)
                }
            }
            filteredName = filteredData!.map{ $0.name }
        }
        self.listTableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        let index = navigationController!.viewControllers.count - 2
        let vc = navigationController?.viewControllers[index] as! DetailCollectionViewController
        
        vc.weatherDataManager.setMyWeatherViewList()
        filteredData = vc.weatherDataManager.getMySortedWeatherListView()
        filteredName = nil
        listTableView.reloadData()
        
    }
    
}

extension ListViewController : UITableViewDataSource, UITableViewDelegate {
    
    //컨텐츠 몇개?
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(#function + " START ")
        if filteredName?.isEmpty == nil{
            print(filteredData!.count) // ⚠️ fatal Error Point : 전체 배열 다들어가있음...!!
            print(#function + " DONE ")
            return filteredData!.count
        } else {
            print(#function + " DONE ")
            return filteredName!.count
        }
        
    }
    
    // 셀 표현
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print(#function)
        
        if let filteredNames = filteredName {
            var temp : [Weather] = []
            temp = filteredData!.filter{
                filteredNames.contains($0.name)
            }
            filteredData = temp
        }
        // dequeueReusableCell의 리턴값이 UITableViewCell 이기 때문에 MovieCell 타입으로 다시 캐스팅 해줘야함.
        let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherCell", for: indexPath) as! WeatherCell
        
        let index = navigationController!.viewControllers.count - 2  // 바로 전 화면 인덱스
        let vc = navigationController?.viewControllers[index] as! DetailCollectionViewController
        
        // filteredData의 데이터를 최신화하기 위함.
        var array: [Weather] = []
        vc.weatherDataManager.getMySortedWeatherListView().forEach{ data in
            
            let result = filteredData?.filter{ $0.name == data.name}
            if let result { array.append(contentsOf: result) }
        }
        
        
        let weather = array[indexPath.row] //이걸로 코드 줄여도 됨
        
        cell.myHome = DataManager.myHome
        cell.myName = weather.name
        cell.isMyList = weather.isMyList
        cell.regionNameLabel.text = weather.name
        cell.weatherIcon.image = weather.icon
        cell.selectionStyle = .none
        
        return cell
    }
    
    
    // 셀이 선택됐을때에 대한 반응
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 세그웨이를 사용할땐 항상 사용. ( sender는 정보전달 )
        print("\n" + #function + "----------------------------------------")
        
        let selectedItem = filteredData![indexPath.row]
        print("\(selectedItem.name) 선택됨")
        
        if let myHomeName = DataManager.myHome?.name {
            
            if selectedItem.name == myHomeName {
                popOneButtonAlertUp(title: "집으로 설정된 지역입니다", message: "집은 홈 리스트에서 제거할 수 없어요, 홈 화면에서 집을 변경해주세요", buttonLetter: "알겠습니다")
                return
            }
        }
        tableView.beginUpdates()
        print("업데이트 시작")
        
        let pathIndex = selectedItem.iDnum
        let index = navigationController!.viewControllers.count - 2
        let vc = navigationController?.viewControllers[index] as! DetailCollectionViewController
//        ⚠️여기서부터 토스트 알림 구현하기
        
        
        
        if selectedItem.isMyList == true && DataManager.myWeatherViewList.count == 1 {
            popOneButtonAlertUp(title: "지역을 선택해주세요.", message: "하나 이상의 지역을 선택해주세요", buttonLetter: "예")
        }else if selectedItem.isMyList == true {
            vc.weatherDataManager.addMyWeatherViewList(index: pathIndex)
            showToast(message: "\(selectedItem.name) 선택 해제", font: UIFont.systemFont(ofSize: 17, weight: .heavy), width: 300, height: 35, boxColor: UIColor.orange)
        }else{
            vc.weatherDataManager.addMyWeatherViewList(index: pathIndex)
            showToast(message: "\(selectedItem.name) 선택완료", font: UIFont.systemFont(ofSize: 17, weight: .heavy), width: 300, height: 35, boxColor: UIColor(red: 0.0588, green: 0.6, blue: 0, alpha: 1.0))
        }
        filteredData = vc.weatherDataManager.getMySortedWeatherListView()
        tableView.reloadData()
        print("\n^^^^^^^^^^^^^^^^^^^^^^^^ Reload Data")
        tableView.endUpdates()
        print("\(selectedItem.name)[\(selectedItem.iDnum)] 선택 업데이트 완료")
    }
    
    
    func showToast(message : String, font: UIFont, width: CGFloat, height: CGFloat, boxColor: UIColor) {
        // 메세지창 위치지정
        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.width/2 - width/2, y: self.view.frame.size.height-100, width: width, height: height))
        toastLabel.backgroundColor = boxColor.withAlphaComponent(1.0)
        toastLabel.textColor = UIColor.white
        toastLabel.font = font
        toastLabel.textAlignment = .center;
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 1.3, delay: 1.3, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
    
    
    func popOneButtonAlertUp(title: String, message: String, buttonLetter: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let yes = UIAlertAction(title: buttonLetter, style: UIAlertAction.Style.default)
        
        alert.addAction(yes)
        self.present(alert, animated: true)
    }
    
    
    
    
    
    //스와이프해서 삭제 (일단 패스)
    //    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    //
    //          if editingStyle == .delete {
    //
    //              dataArray.remove(at: indexPath.row)
    //              tableView.deleteRows(at: [indexPath], with: .fade)
    //
    //          } else if editingStyle == .insert {
    //
    //          }
    //      }
    
}



