//
//  DetailCollectionViewController.swift
//  Logan_Hackathon_WeatherApp
//
//  Created by DONGWOOK SEO on 2022/10/08.
//

import UIKit

class DetailCollectionViewController: UIViewController {
    
    @IBOutlet weak var detailCollectionView: UICollectionView!
    
    let flowLayout = UICollectionViewFlowLayout()
    
    var myCityList: [Weather]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        detailCollectionView.delegate = self
        setupCollectionView()
        
    }
    
    // 화면이 출력될 때
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // 네비게이션바 없앰
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    //화면이 사라지고 다음으로 넘어갈때
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // 네비게이션바 다시 표시
        navigationController?.setNavigationBarHidden(false, animated: animated)
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
        print("ButtonTapped")
    }
    
    
    @IBAction func addButtonTapped(_ sender: UIButton) {
        
        performSegue(withIdentifier: "toListVC", sender: self)
        
    }
    
    @IBAction func configureTapped(_ sender: UIButton) {
        
        
    }
    
    
    
}

//MARK: - extensions below
extension DetailCollectionViewController: UICollectionViewDelegate{
    
}

extension DetailCollectionViewController: UICollectionViewDataSource {
    
    //컬렉션뷰 몇개 만들지?
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.myCityList!.count
    }
    
    // 각 콜렉션뷰 Cell에 대한 설정
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DetailViewCell", for: indexPath) as! CollectionViewCell
        
        cell.regionNameLabel.text = myCityList![indexPath.item].name
        cell.currentTemperatureLabel.text = myCityList![indexPath.item].currentTemperature
        cell.weatherIcon.image = myCityList![indexPath.item].icon
        cell.weatherDescriptionLabel.text = myCityList![indexPath.item].description.rawValue
        cell.currentHumidityLabel.text = myCityList![indexPath.item].currentHumidity
        cell.maxTemperatureLabel.text = myCityList![indexPath.item].maxTemperature
        cell.minTemperatureLabel.text = myCityList![indexPath.item].minTemperature
        
        return cell
    }
}


