//
//  ViewController.swift
//  Logan_Hackathon_WeatherApp
//
//  Created by DONGWOOK SEO on 2022/10/05.
//

import UIKit
import CoreLocation

/// 구조체면 동작 안함 이유를 알아보자
class Section {
    var data: Weather
    let contents: Int = 5
    //    lazy var title: String = data.name
    lazy var icon = data.icon
    lazy var isMyCity = data.isMyCity
    
    lazy var isOpen = data.isOpen {
        didSet {
            print(oldValue,"======>",isOpen)
        }
    }
    
    init(data: Weather) {
        self.data = data
        //        self.isOpen = isOpen
        print("생성 - ", data.name)
    }
}

class ListViewController: UIViewController {
    
    
    @IBOutlet weak var listTableView: UITableView!
    
    let searchController = UISearchController()
    
    // 직접적으로 유저에게 보여질 데이터, 상호작용할 데이터 묶음
    //    var shownData: [Weather]?
    
    // filteredData에 들어갈 WeatherData를 선별할 filter
    var filterNames: [String] = [] {
        didSet {
            print("filterNames ::::", oldValue, "===>", filterNames)
        }
    }
    
    //섹션만들기
    private var sections: [Section] = []
    
    
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
        listTableView.delegate = self
        
        sections = setSections()
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
        print(#function)
        let index = navigationController!.viewControllers.count - 2
        let vc = navigationController?.viewControllers[index] as! DetailCollectionViewController
        
        let filteredDatas = vc.dataManager.getFilteredData(filter: filterNames)
        
        let weatherSections = filteredDatas.map{
            Section(data: $0)
        }
        return weatherSections
    }
    
    func toggleOpen() {
        let index = navigationController!.viewControllers.count - 2
        let vc = navigationController?.viewControllers[index] as! DetailCollectionViewController
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
        self.sections = self.setSections()
        self.listTableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        let index = navigationController!.viewControllers.count - 2
        let vc = navigationController?.viewControllers[index] as! DetailCollectionViewController
        
        vc.dataManager.setMyWeatherViewList()
        filterNames = vc.myList
        sections = setSections()
        listTableView.reloadData()
    }
    
}

extension ListViewController : UITableViewDataSource, UITableViewDelegate {
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        //        return sections.count
        
        return filterNames.count
        
    }
    
    
    //컨텐츠 몇개?
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
                
        let section = sections[section]
        
        if section.data.isOpen {
            return section.contents
        } else {
            return 1
        }
        
        
        
        
    }
    
    //셀 높이
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 70
        }else {
            return 40
        }
    }
    
    // 셀 표현
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if filterNames.isEmpty {
            sections = setSections()
        }
        
        let index = navigationController!.viewControllers.count - 2  // 바로 전 화면 인덱스
        let vc = navigationController?.viewControllers[index] as! DetailCollectionViewController
        
        
        ///<섹션만들기>
        let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherCell", for: indexPath) as! WeatherCell

        let section = sections[indexPath.section]
        
        cell.dataIndex = indexPath.row
        cell.data = section.data
        cell.selectionStyle = .none
        
        cell.myHome = vc.dataManager.getMyHome()
        cell.myName = section.data.name
        cell.isMyCity = section.isMyCity
        cell.myList = vc.myList
        
        return cell
    }
    
    
    // 셀이 선택됐을때에 대한 반응
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let index = navigationController!.viewControllers.count - 2
        let vc = navigationController?.viewControllers[index] as! DetailCollectionViewController
        
        let selectedItem = sections[indexPath.section]
        
        
        if indexPath.row == 0 && vc.myList.contains(selectedItem.data.name) {
            sections[indexPath.section].data.isOpen.toggle()
            listTableView.reloadSections([indexPath.section], with: .none)
        }
        
    }
    
    
    // 좌로 스와이프 삭제기능
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let index = navigationController!.viewControllers.count - 2
        let vc = navigationController!.viewControllers[index] as! DetailCollectionViewController
        
        let selectedItem = sections[indexPath.section]
        
        if indexPath.row > 0 {
            return nil
        }
        
        
        if vc.myList.contains(selectedItem.data.name){
            let Delete = UIContextualAction(style: .normal, title: "Delete") { [self] (UIContextualAction, UIView, success: @escaping (Bool) -> Void) in
                
                let shouldDeletedName = self.sections[indexPath.section].data.name
                
                // myHome이 있을경우
                if let myHomeName = vc.dataManager.getNames(iWannaGet: .myHome){
                    print("myHome 있는 분기")
                    if !myHomeName.contains(shouldDeletedName) && !vc.dataManager.getNames(iWannaGet: .myViewList)!.contains(shouldDeletedName){
                        
                        vc.myList = vc.myList.filter{$0 != selectedItem.data.name}
                        self.filterNames = filterNames.filter{$0 != selectedItem.data.name}
                        self.sections = self.setSections()
                        tableView.reloadData()
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
                        
                        // ⭐️⭐️⭐️ indexPath.row를 이용해서 인덱스를 받아와서 그 인덱스 기준으로 특정 셀의 위치를 편집(삭제)하다보면 이후 즐겨찾기등록으로 인해 재편성된 리스트에서 에러가 생기기 때문에 인덱스 값이 아닌 이름값을 대조하여 편집하도록 바꿈. (현재는 분석을 깊게하지 않았음, 정확한 진단이 아니기 때문에 맞는지 확인 해볼것.)
                        //filterNames?.remove(at: indexPath.row) 사용안함
                        //⚠️ 꼭 myList와 filterNames가 따로 움직일 필요가 있을까? 생각해보기
                        vc.myList = vc.myList.filter{$0 != selectedItem.data.name}
                        filterNames = filterNames.filter{$0 != selectedItem.data.name}
                        self.sections = self.setSections()
                        tableView.reloadData()
//                        tableView.deleteRows(at: [indexPath], with: .left)
                        
                        
                        showToast(message: "\(selectedItem.data.name) 제거", font: UIFont.systemFont(ofSize: 17, weight: .heavy), width: 300, height: 35, boxColor: .systemRed)
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
        
        if indexPath.row > 0 {
            return nil
        }
        
        let index = navigationController!.viewControllers.count - 2
        let vc = navigationController!.viewControllers[index] as! DetailCollectionViewController
        sections = setSections()
        
        print("^^^^^^^^^^^^^^^^^^^^",filterNames)
        let selectedItem = sections[indexPath.section]
        print("%%%%%%%%%%%%%%%%%%%", selectedItem.data.name)
        
        
        // 즐겨찾기에 없는 아이템일때 (삭제상태)  : ADD
        if !vc.myList.contains(selectedItem.data.name){
            let add = UIContextualAction(style: .normal, title: "Add") { [self] (UIContextualAction, UIView, success: @escaping (Bool) -> Void) in
                print("Add 클릭 됨")
                
                
                vc.myList.append(selectedItem.data.name)
                
                showToast(message: "\(selectedItem.data.name) 즐겨찾기 등록", font: UIFont.systemFont(ofSize: 17, weight: .heavy), width: 300, height: 35, boxColor: .systemTeal)
                
//                self.listTableView.reloadSections([indexPath.section], with: .automatic)
                self.listTableView.reloadData()
                success(true)
                
            }
            
            add.backgroundColor = .systemTeal
            print("버튼 칼라설정")
            
            //actions배열 인덱스 0이 왼쪽에 붙어서 나옴
            return UISwipeActionsConfiguration(actions:[add])
        }
        
        // 내 도시에 없는 아이템일때 : Like
        else if !selectedItem.isMyCity{
            
            let like = UIContextualAction(style: .normal, title: "Like") { (UIContextualAction, UIView, success: @escaping (Bool) -> Void) in
                print("Like 클릭 됨")
                
                vc.dataManager.toggleWeatherToViewList(name: selectedItem.data.name)
                self.sections = self.setSections()
                print(self.sections,"뭐가 들었누")
                
                
                self.showToast(message: "\(selectedItem.data.name) 선택완료", font: UIFont.systemFont(ofSize: 17, weight: .heavy), width: 300, height: 35, boxColor: UIColor(red: 0.0588, green: 0.6, blue: 0, alpha: 1.0))
                
                
                self.listTableView.reloadData()
                print("섹션 리로드 함.")
                success(true)
                
            }
            
            print("Like 준비?? ")
            like.backgroundColor = .magenta
            return UISwipeActionsConfiguration(actions:[like])
        }
        
        // 이미 내도시에 있는 아이템일때. : Unlike-
        else if selectedItem.isMyCity{
            
            let unlike = UIContextualAction(style: .normal, title: "Unlike") { (UIContextualAction, UIView, success: @escaping (Bool) -> Void) in
                
                print(selectedItem.data.name,"Unlike 클릭 됨")
                
                if let myHomeName = vc.dataManager.getMyHome()?.name  {
                    print("집으로 설정된 지역이 있음.")
                    if selectedItem.data.name == myHomeName {
                        self.popOneButtonAlertUp(title: "집으로 설정된 지역입니다", message: "집은 즐겨찾기에서 제거할 수 없어요, 홈 화면에서 집을 변경해주세요", buttonLetter: "알겠습니다")
                        success(false)
                    }

                }
                
                if selectedItem.isMyCity == true && vc.dataManager.getMyWeatherViewList().count == 1 {
                    self.popOneButtonAlertUp(title: "하나 이상의 지역을 선택해주세요.", message: "", buttonLetter: "알겠습니다")
                    success(false)
                }
                
                else {
                    print("Unlike 진행")
                    vc.dataManager.toggleWeatherToViewList(name: selectedItem.data.name)
                    
                    
                    self.showToast(message: "\(selectedItem.data.name) 선택 해제", font: UIFont.systemFont(ofSize: 17, weight: .heavy), width: 300, height: 35, boxColor: UIColor.orange)
                    
                    self.sections = self.setSections()
                    self.listTableView.reloadData()
                    success(true)
                }
            }
            unlike.backgroundColor = .orange
            return UISwipeActionsConfiguration(actions:[unlike])
        }
        
        else {
            print("Unlike 아님")
            return nil
        }
        
    }
    
}



