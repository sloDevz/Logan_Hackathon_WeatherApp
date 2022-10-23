//
//  ViewController.swift
//  Logan_Hackathon_WeatherApp
//
//  Created by DONGWOOK SEO on 2022/10/05.
//

import UIKit
import CoreLocation


class ListViewController: UIViewController {
    
    struct Section {
        let title: String
        var isOpen = false
        
        init(title: String, isOpen: Bool = false) {
            self.title = title
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
//    var sections = [Section]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        
    }
    
    func setUp() {
        navigationItem.searchController = searchController
        navigationItem.searchController?.searchBar.placeholder = "지역찾기"
        searchController.searchBar.delegate = self
        searchController.searchResultsUpdater = self
        
//        sections = makeSections(names: filterNames)
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
    
//    func makeSections(names:[String]) -> [Section] {
//
//        // filterNames에 따라서 섹션 만들기
//        let section = names.map{ Section.init(title: $0) }
//
//        return section
//    }
    
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
    
    
//    func numberOfSections(in tableView: UITableView) -> Int {
//        sections.count
//    }
    
    
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
        
        
        
        // filteredData의 데이터를 최신화하기 위함.
        //        var array: [Weather] = []
        //        vc.dataManager.getAllMySortedWeatherListView().forEach{ data in
        //
        //            let result = shownData?.filter{ $0.name == data.name}
        //            if let result { array.append(contentsOf: result) }
        //        }
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
        
        if vc.myList.contains(selectedItem.name){
            
            if let myHomeName = vc.dataManager.getMyHome()?.name {
                
                if selectedItem.name == myHomeName {
                    popOneButtonAlertUp(title: "집으로 설정된 지역입니다", message: "집은 즐겨찾기에서 제거할 수 없어요, 홈 화면에서 집을 변경해주세요", buttonLetter: "알겠습니다")
                    return
                }
            }
            tableView.beginUpdates()
            print("업데이트 시작")
            
            if selectedItem.isMyCity == true && vc.dataManager.getMyWeatherViewList().count == 1 {
                popOneButtonAlertUp(title: "지역을 선택해주세요.", message: "하나 이상의 지역을 선택해주세요", buttonLetter: "예")
            }else if selectedItem.isMyCity == true {
                vc.dataManager.toggleWeatherToViewList(name: selectedItem.name)
                
                showToast(message: "\(selectedItem.name) 선택 해제", font: UIFont.systemFont(ofSize: 17, weight: .heavy), width: 300, height: 35, boxColor: UIColor.orange)
            }else{
                vc.dataManager.toggleWeatherToViewList(name: selectedItem.name)
                
                showToast(message: "\(selectedItem.name) 선택완료", font: UIFont.systemFont(ofSize: 17, weight: .heavy), width: 300, height: 35, boxColor: UIColor(red: 0.0588, green: 0.6, blue: 0, alpha: 1.0))
            }
            shownData = vc.dataManager.getFilteredData(filter: filterNames)
            tableView.reloadData()
            print("\n^^^^^^^^^^^^^^^^^^^^^^^^ Reload Data")
            tableView.endUpdates()
            print("\(selectedItem.name)[\(selectedItem.iDnum)] 선택 업데이트 완료")
        }else { print("목록에 없는 데이터입니다"); return }
    }
    
    
    
    
    //스와이프해서 삭제
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        let sellectedItem = shownData![indexPath.row]
        let index = navigationController!.viewControllers.count - 2
        let vc = navigationController?.viewControllers[index] as! DetailCollectionViewController
        
        if vc.myList.contains(sellectedItem.name){
            if editingStyle == .delete {
                let shouldDeletedName = shownData![indexPath.row].name
                
                // myHome이 있을경우
                if let myHomeName = vc.dataManager.getNames(iWannaGet: .myHome){
                    print("myHome 있는 분기")
                    if !myHomeName.contains(shouldDeletedName) && !vc.dataManager.getNames(iWannaGet: .myViewList)!.contains(shouldDeletedName){
                        
                        vc.myList = vc.myList.filter{$0 != sellectedItem.name}
                        filterNames = filterNames.filter{$0 != sellectedItem.name}
                        tableView.deleteRows(at: [indexPath], with: .fade)
                        print("\(shouldDeletedName) 제거")
                    }else if vc.dataManager.getNames(iWannaGet: .myHome)!.contains(shouldDeletedName){
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
                    if !vc.dataManager.getNames(iWannaGet: .myViewList)!.contains(shouldDeletedName){
                        
                        //                    vc.dataManager.removeWeatherDataArray(name: sellectedItem.name)
                        
                        // ⭐️⭐️⭐️ indexPath.row를 이용해서 인덱스를 받아와서 그 인덱스 기준으로 특정 셀의 위치를 편집(삭제)하다보면 이후 즐겨찾기등록으로 인해 재편성된 리스트에서 에러가 생기기 떄문에 인덱스 값이 아닌 이름값을 대조하여 편집하도록 바꿈. (현재는 분석을 깊게하지 않았음, 정확한 진단이 아니기 때문에 맞는지 확인 해볼것.)
                        //filterNames?.remove(at: indexPath.row) 사용안함
                        //⚠️ 꼭 myList와 filterNames가 따로 움직일 필요가 있을까? 생각해봐야함
                        vc.myList = vc.myList.filter{$0 != sellectedItem.name}
                        filterNames = filterNames.filter{$0 != sellectedItem.name}
                        tableView.deleteRows(at: [indexPath], with: .fade)
                        
                    } else {
                        popOneButtonAlertUp(title: "", message: "즐겨찾기중인 지역은 삭제할 수 없습니다", buttonLetter: "확인")
                        return
                    }
                }
            }
        } else {
            popOneButtonAlertUp(title: "", message: "해당지역은 이미 목록에 없습니다", buttonLetter: "확인")
        }
        // 리스트 추가기능 구현하기
        if editingStyle == .insert {
            //            tableView.insertRows(at: indexPath, with: .top)
        }
    }
    
    
    
    
    // 좌로 스와이프 액션
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        // 왼쪽에 만들기
        
        let like = UIContextualAction(style: .normal, title: "Like") { (UIContextualAction, UIView, success: @escaping (Bool) -> Void) in
            print("Like 클릭 됨")
            success(true)
        }
        like.backgroundColor = .systemPink
        
        
        let share = UIContextualAction(style: .normal, title: "Share") { (UIContextualAction, UIView, success: @escaping (Bool) -> Void) in
            print("Share 클릭 됨")
            success(true)
        }
        share.backgroundColor = .systemTeal
        
        //actions배열 인덱스 0이 왼쪽에 붙어서 나옴
        return UISwipeActionsConfiguration(actions:[like, share])
        
    }
    
}



