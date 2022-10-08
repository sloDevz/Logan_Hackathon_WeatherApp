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
    
    private var dataSource = (0...3).map(Int.init(_:))
    private var currentItem = -1
    private var currentIndexPath: IndexPath {
        IndexPath(item: self.currentItem, section: 0)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

    }
}

extension DetailCollectionViewController: UICollectionViewDataSource {
    
    //컬렉션뷰 몇개 만들지?
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.dataSource.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DetailViewCell", for: indexPath) as! CollectionViewCell
        
        
        return cell
    }
}
