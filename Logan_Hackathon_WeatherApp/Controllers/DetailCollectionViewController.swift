//
//  DetailCollectionViewController.swift
//  Logan_Hackathon_WeatherApp
//
//  Created by DONGWOOK SEO on 2022/10/08.
//

import UIKit

class DetailCollectionViewController: UIViewController {
    
    @IBOutlet weak var detailCollectionView: UICollectionView!
    
    var selectedCity: [Weather]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        detailCollectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        detailCollectionView.dataSource = self
        detailCollectionView.delegate = self
    }
}

extension DetailCollectionViewController: UICollectionViewDelegate{
    
    
    
    
    
}

extension DetailCollectionViewController: UICollectionViewDataSource {
    
    //컬렉션뷰 몇개 만들지?
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.selectedCity!.count
    }
    
    // 각 콜렉션뷰 Cell에 대한 설정
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cellId = String(describing: CollectionViewCell.self)
        print("cellID: \(cellId)")
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! CollectionViewCell
        
        cell.regionNameLabel.text = selectedCity![indexPath.item].name
        cell.currentTemperatureLabel.text = selectedCity![indexPath.item].currentTemperature
        cell.weatherIcon.image = selectedCity![indexPath.item].icon
        cell.weatherDescriptionLabel.text = selectedCity![indexPath.item].description.rawValue
        
        return cell
    }
}
















