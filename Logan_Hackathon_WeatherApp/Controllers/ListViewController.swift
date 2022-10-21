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
            print(filteredData!.count)
            print(#function + " filtered Data will do ")
            return filteredData!.count
        } else {
            print(filteredName!.count)
            print(#function + " filtered Name will do ")
            return filteredName!.count
        }
        
    }
    
    // 셀 표현
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print(#function)
        
        // filteredName이 Nil이 아닐때 그안의 이름들에 해당하는 데이터를 filteredData에 넣어주기
        if let filteredNames = filteredName {
            var temp : [Weather] = []
            temp = filteredData!.filter{
                filteredNames.contains($0.name)
            }
            filteredData = temp
        }
        // dequeueReusableCell의 리턴값이 UITableViewCell 이기 때문에 WeatherCell 타입으로 다시 캐스팅 해줘야함.
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
        
        let index = navigationController!.viewControllers.count - 2
        let vc = navigationController?.viewControllers[index] as! DetailCollectionViewController
       
        if selectedItem.isMyList == true && DataManager.myWeatherViewList.count == 1 {
            popOneButtonAlertUp(title: "지역을 선택해주세요.", message: "하나 이상의 지역을 선택해주세요", buttonLetter: "예")
        }else if selectedItem.isMyList == true {
            vc.weatherDataManager.toggleWeatherToViewList(name: selectedItem.name)
            showToast(message: "\(selectedItem.name) 선택 해제", font: UIFont.systemFont(ofSize: 17, weight: .heavy), width: 300, height: 35, boxColor: UIColor.orange)
        }else{
            vc.weatherDataManager.toggleWeatherToViewList(name: selectedItem.name)
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
    
    
    //스와이프해서 삭제
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        let sellectedItem = filteredData![indexPath.row]
        let index = navigationController!.viewControllers.count - 2
        let vc = navigationController?.viewControllers[index] as! DetailCollectionViewController
        
        if editingStyle == .delete {
            let shouldDeletedName = filteredData![indexPath.row].name
            
            // myHome이 있을경우
            if let myHomeName = vc.weatherDataManager.getNames(iWannaGet: .myHome){
                print("myHome 있는 분기")
                if !myHomeName.contains(shouldDeletedName) && !vc.weatherDataManager.getNames(iWannaGet: .myViewList)!.contains(shouldDeletedName){
                    vc.weatherDataManager.removeWeatherDataArray(name: sellectedItem.name)
                    filteredData!.remove(at: indexPath.row)
                    tableView.deleteRows(at: [indexPath], with: .fade)
                    print("\(shouldDeletedName) 제거")
                }else if vc.weatherDataManager.getNames(iWannaGet: .myHome)!.contains(shouldDeletedName){
                    popOneButtonAlertUp(title: "", message: "집은 리스트에서 제거할 수 없습니다", buttonLetter: "확인")
                }
                else{
                    popOneButtonAlertUp(title: "", message: "즐겨찾기중인 지역은 삭제할 수 없습니다", buttonLetter: "확인")
                    return
                }
            }
            // myHome이 없을경우
            else {
                print("myHome 없는 분기")
                // 제거하려는 항목이 내 리스트에 들어가있지 않다면
                if !vc.weatherDataManager.getNames(iWannaGet: .myViewList)!.contains(shouldDeletedName){
                    vc.weatherDataManager.removeWeatherDataArray(name: sellectedItem.name)
                    filteredData!.remove(at: indexPath.row)
                    filteredName!.remove(at: indexPath.row)
                    tableView.deleteRows(at: [indexPath], with: .fade)
                    print("\(shouldDeletedName) 제거")
                    print("제거후 데이터 갯수 \(filteredData?.count)")
                    print("제거후 VC 데이터 갯수 \(vc.weatherDataManager.getAllWeatherList().count)")
                } else {
                    popOneButtonAlertUp(title: "", message: "즐겨찾기중인 지역은 삭제할 수 없습니다", buttonLetter: "확인")
                    return
                }
            }

            
            // 리스트 추가기능 구현하기
        } else if editingStyle == .insert {
//            tableView.insertRows(at: indexPath, with: .top)
        }
    }
    
       
}



