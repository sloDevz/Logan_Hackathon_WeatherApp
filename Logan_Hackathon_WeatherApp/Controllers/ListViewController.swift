//
//  ViewController.swift
//  Logan_Hackathon_WeatherApp
//
//  Created by DONGWOOK SEO on 2022/10/05.
//

import UIKit
import CoreLocation


final class ListViewController: UIViewController {
    
    @IBOutlet weak var listTableView: UITableView!
    let searchController = UISearchController()
    
    var weatherDataManager: DataManager?
    //    override var searchDisplayController = UISearchController()
    var dataArray: [Weather]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUp()
        
    }
    
    func setUp() {
//        searchController.searchResultsUpdater = self
        listTableView.dataSource = self
        listTableView.rowHeight = 80
        listTableView.delegate = self
    }
    
}

//MARK: - Extensions below
extension ListViewController : UITableViewDataSource, UITableViewDelegate {
    
    
    
    //컨텐츠 몇개?
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherDataManager!.getAllWeatherList().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // dequeueReusableCell의 리턴값이 UITableViewCell 이기 때문에 MovieCell 타입으로 다시 캐스팅 해줘야함.
        let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherCell", for: indexPath) as! WeatherCell
        
        let array = weatherDataManager?.getAllWeatherList()
        let weather = array![indexPath.row] //이걸로 코드 줄여도 됨
        
        cell.myHome = DataManager.myHome
        cell.myId = weather.iDnum
        cell.isMyList = weather.isMyList
        cell.regionNameLabel.text = weather.name
        cell.weatherIcon.image = weather.icon
        cell.selectionStyle = .none
        
        
        return cell
    }
    
    
    // 셀이 선택됐을때에 대한 반응
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 세그웨이를 사용할땐 항상 사용. ( sender는 정보전달 )
        print(#function)
        
        let selectedItem = weatherDataManager!.getAllWeatherList()[indexPath.row]
        
        
        if selectedItem.iDnum == DataManager.myHome {
            popOneButtonAlertUp(title: "집으로 설정된 지역입니다", message: "집은 홈 리스트에서 제거할 수 없어요, 홈 화면에서 집을 변경해주세요", buttonLetter: "알겠습니다")
            return
        }
        
        tableView.beginUpdates()
        let pathIndex = indexPath.row
        let index = navigationController!.viewControllers.count - 2
        let vc = navigationController?.viewControllers[index] as! DetailCollectionViewController
        
        
        
        if selectedItem.isMyList == true && DataManager.myWeatherViewList.count == 1 {
            popOneButtonAlertUp(title: "지역을 선택해주세요.", message: "하나 이상의 지역을 선택해주세요", buttonLetter: "예")
        }else{
            vc.weatherDataManager.addMyWeatherViewList(index: pathIndex)
        }
        tableView.reloadData()
        tableView.endUpdates()
        print(DataManager.myHome)
        print(selectedItem.iDnum)
        // 선택된 셀의 요소를 myCityList 배열중 가장 첫번째로 옮기기.
        //        weatherDataManager.myWeatherDataList.swapAt(0, indexPath.row)
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


