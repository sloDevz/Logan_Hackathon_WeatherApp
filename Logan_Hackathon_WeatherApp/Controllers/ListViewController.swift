//
//  ViewController.swift
//  Logan_Hackathon_WeatherApp
//
//  Created by DONGWOOK SEO on 2022/10/05.
//

import UIKit
import CoreLocation


class ListViewController: UIViewController {
    
    //섹션기능 (보류)
    
    struct Section {
        lazy var title: String = data.name
        let data: Weather
        var isOpen = false
        
        init(data: Weather, isOpen: Bool = false) {
            self.data = data
            self.isOpen = isOpen
        }
    }
        
    
    @IBOutlet weak var listTableView: UITableView!
    
    let searchController = UISearchController()
    
    // 직접적으로 유저에게 보여질 데이터, 상호작용할 데이터 묶음
    var shownData: [Weather]?
    
    // filteredData에 들어갈 WeatherData를 선별할 filter
    var filterNames: [String] = [] {
        didSet {
            print("filterNames ::::", oldValue, "===>", filterNames)
        }
    }
    
    //섹션만들기 (보류)
    //    private var sections = [Section]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        
    }
    
    func setUp() {
        navigationItem.searchController = searchController
        navigationItem.searchController?.searchBar.placeholder = "지역찾기"
        searchController.searchBar.delegate = self
        searchController.searchResultsUpdater = self
        
        
        listTableView.dataSource = self
        listTableView.rowHeight = 80
        listTableView.delegate = self
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
    
//    섹션만들기 기능
    func setSections() -> [Section] {
        let index = navigationController!.viewControllers.count - 2
        let vc = navigationController?.viewControllers[index] as! DetailCollectionViewController
        
        let filteredDatas = vc.dataManager.getFilteredData(filter: filterNames)
        
        var weatherSections = filteredDatas.map{
            Section(data: $0)
        }
            return weatherSections
        }
    
}

//MARK: - Extensions below

extension ListViewController: UISearchResultsUpdating, UISearchBarDelegate {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        print(text)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let index = navigationController!.viewControllers.count - 2
        let vc = navigationController?.viewControllers[index] as! DetailCollectionViewController
        
        filterNames = []
        
        
        vc.dataManager.setMyWeatherViewList()
        
        if searchText == "" {
            filterNames = vc.myList
        }
        else {
            filterNames = vc.dataManager.getAllMySortedWeatherListView().map{$0.name}.filter { $0.hasPrefix(searchText) }
        }
        self.listTableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        let index = navigationController!.viewControllers.count - 2
        let vc = navigationController?.viewControllers[index] as! DetailCollectionViewController
        
        vc.dataManager.setMyWeatherViewList()
        filterNames = vc.myList
        listTableView.reloadData()
    }
    
}

extension ListViewController : UITableViewDataSource, UITableViewDelegate {
    
    //컨텐츠 몇개?
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let index = navigationController!.viewControllers.count - 2  // 바로 전 화면 인덱스
        let vc = navigationController?.viewControllers[index] as! DetailCollectionViewController
        
        shownData = vc.dataManager.getFilteredData(filter: filterNames)
        print(#function + "\(filterNames)")
        
        return shownData!.count
        
    }
    
    // 셀 표현
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print(#function)
        let index = navigationController!.viewControllers.count - 2  // 바로 전 화면 인덱스
        let vc = navigationController?.viewControllers[index] as! DetailCollectionViewController
        
        // filteredName이 Nil이 아닐때 그안의 이름들에 해당하는 데이터를 shownData에 넣어주기
        if !filterNames.isEmpty {
            shownData = vc.dataManager.getFilteredData(filter: filterNames)
        }
        // dequeueReusableCell의 리턴값이 UITableViewCell 이기 때문에 WeatherCell 타입으로 다시 캐스팅 해줘야함.
        let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherCell", for: indexPath) as! WeatherCell
        
        
        print("myList ::",vc.myList)
        
        let weather = shownData![indexPath.row] //이걸로 코드 줄여도 됨
        
        cell.myHome = vc.dataManager.getMyHome()
        cell.myName = weather.name
        cell.isMyCity = weather.isMyCity
        cell.myList = vc.myList
        cell.regionNameLabel.text = weather.name
        cell.weatherIcon.image = weather.icon
        cell.selectionStyle = .none
        
        return cell
    }
    
    
    // 셀이 선택됐을때에 대한 반응
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let index = navigationController!.viewControllers.count - 2
        let vc = navigationController?.viewControllers[index] as! DetailCollectionViewController
        
        let selectedItem = shownData![indexPath.row]
        print("\(selectedItem.name) 선택됨")
        
        
        
        
        
        
    }
    
    
    // 좌로 스와이프 삭제기능
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let index = navigationController!.viewControllers.count - 2
        let vc = navigationController!.viewControllers[index] as! DetailCollectionViewController
        
        let selectedItem = shownData![indexPath.row]
        
        if vc.myList.contains(selectedItem.name){
            let Delete = UIContextualAction(style: .normal, title: "Delete") { [self] (UIContextualAction, UIView, success: @escaping (Bool) -> Void) in
                
                let shouldDeletedName = self.shownData![indexPath.row].name
                
                // myHome이 있을경우
                if let myHomeName = vc.dataManager.getNames(iWannaGet: .myHome){
                    print("myHome 있는 분기")
                    if !myHomeName.contains(shouldDeletedName) && !vc.dataManager.getNames(iWannaGet: .myViewList)!.contains(shouldDeletedName){
                        
                        vc.myList = vc.myList.filter{$0 != selectedItem.name}
                        self.filterNames = filterNames.filter{$0 != selectedItem.name}
                        tableView.deleteRows(at: [indexPath], with: .left)
                        print("\(shouldDeletedName) 제거")
                        
                    }else if vc.dataManager.getNames(iWannaGet: .myHome)!.contains(shouldDeletedName){
                        popOneButtonAlertUp(title: "", message: "집은 리스트에서 제거할 수 없습니다", buttonLetter: "확인")
                    }
                    else{
                        popOneButtonAlertUp(title: "", message: "즐겨찾기중인 지역은 삭제할 수 없습니다", buttonLetter: "확인")
                    }
                }
                // myHome이 없을경우
                else {
                    print("myHome 없는 분기")
                    // 제거하려는 항목이 내 리스트에 들어가있지 않다면
                    if !vc.dataManager.getNames(iWannaGet: .myViewList)!.contains(shouldDeletedName){
                        
                        //                    vc.dataManager.removeWeatherDataArray(name: sellectedItem.name)
                        
                        // ⭐️⭐️⭐️ indexPath.row를 이용해서 인덱스를 받아와서 그 인덱스 기준으로 특정 셀의 위치를 편집(삭제)하다보면 이후 즐겨찾기등록으로 인해 재편성된 리스트에서 에러가 생기기 떄문에 인덱스 값이 아닌 이름값을 대조하여 편집하도록 바꿈. (현재는 분석을 깊게하지 않았음, 정확한 진단이 아니기 때문에 맞는지 확인 해볼것.)
                        //filterNames?.remove(at: indexPath.row) 사용안함
                        //⚠️ 꼭 myList와 filterNames가 따로 움직일 필요가 있을까? 생각해보기
                        vc.myList = vc.myList.filter{$0 != selectedItem.name}
                        filterNames = filterNames.filter{$0 != selectedItem.name}
                        tableView.deleteRows(at: [indexPath], with: .left)
                        
                        showToast(message: "\(selectedItem.name) 제거", font: UIFont.systemFont(ofSize: 17, weight: .heavy), width: 300, height: 35, boxColor: .systemRed)
                    }
                    else {
                        popOneButtonAlertUp(title: "", message: "즐겨찾기중인 지역은 삭제할 수 없습니다", buttonLetter: "확인")
                    }
                }
                
                success(true)
            }
            Delete.backgroundColor = .systemRed
            
            //actions배열 인덱스 0이 왼쪽에 붙어서 나옴
            return UISwipeActionsConfiguration(actions:[Delete])
        } else {
            return nil
        }
    }
    
    
    
    // 좌로 스와이프 액션
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let index = navigationController!.viewControllers.count - 2
        let vc = navigationController!.viewControllers[index] as! DetailCollectionViewController
        shownData = vc.dataManager.getFilteredData(filter: filterNames)
        
        print("^^^^^^^^^^^^^^^^^^^^",filterNames)
        let selectedItem = shownData![indexPath.row]
        print("%%%%%%%%%%%%%%%%%%%", selectedItem.name)
        
        
        // 즐겨찾기에 없는 아이템일때 (삭제상태)
        if !vc.myList.contains(selectedItem.name){
            let add = UIContextualAction(style: .normal, title: "Add") { [self] (UIContextualAction, UIView, success: @escaping (Bool) -> Void) in
                print("Add 클릭 됨")
                
                
                vc.myList.append(selectedItem.name)
                listTableView.reloadData()
                
                showToast(message: "\(selectedItem.name) 즐겨찾기 등록", font: UIFont.systemFont(ofSize: 17, weight: .heavy), width: 300, height: 35, boxColor: .systemTeal)
                success(true)
                
            }
            
            add.backgroundColor = .systemTeal
            print("버튼 칼라설정")
            
            //actions배열 인덱스 0이 왼쪽에 붙어서 나옴
            return UISwipeActionsConfiguration(actions:[add])
            
            
            // 내 도시에 없는 아이템일때
        }else if !selectedItem.isMyCity{
            let like = UIContextualAction(style: .normal, title: "Like") { (UIContextualAction, UIView, success: @escaping (Bool) -> Void) in
                print("Like 클릭 됨")
                
                vc.dataManager.toggleWeatherToViewList(name: selectedItem.name)
                
                self.showToast(message: "\(selectedItem.name) 선택완료", font: UIFont.systemFont(ofSize: 17, weight: .heavy), width: 300, height: 35, boxColor: UIColor(red: 0.0588, green: 0.6, blue: 0, alpha: 1.0))
                self.listTableView.reloadData()
                success(true)
            }
            like.backgroundColor = .magenta
            return UISwipeActionsConfiguration(actions:[like])
            
            // 이미 내도시에 있는 아이템일때.
        }else if selectedItem.isMyCity{
            
            let unlike = UIContextualAction(style: .normal, title: "Unlike") { (UIContextualAction, UIView, success: @escaping (Bool) -> Void) in
                print("Unlike 클릭 됨")
                
                if let myHomeName = vc.dataManager.getMyHome()?.name  {
                    if selectedItem.name == myHomeName {
                        self.popOneButtonAlertUp(title: "집으로 설정된 지역입니다", message: "집은 즐겨찾기에서 제거할 수 없어요, 홈 화면에서 집을 변경해주세요", buttonLetter: "알겠습니다")
                        success(false)
                    }
                }else if selectedItem.isMyCity == true && vc.dataManager.getMyWeatherViewList().count == 1 {
                    self.popOneButtonAlertUp(title: "하나 이상의 지역을 선택해주세요.", message: "", buttonLetter: "알겠습니다")
                    success(false)
                }else {
                    vc.dataManager.toggleWeatherToViewList(name: selectedItem.name)
                    
                    self.showToast(message: "\(selectedItem.name) 선택 해제", font: UIFont.systemFont(ofSize: 17, weight: .heavy), width: 300, height: 35, boxColor: UIColor.orange)
                    self.listTableView.reloadData()
                    success(true)
                }
            }
            unlike.backgroundColor = .orange
            return UISwipeActionsConfiguration(actions:[unlike])
        } else {
            return nil
        }
        
    }
    
}



