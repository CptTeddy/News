//
//  PersonalControllerViewController.swift
//  news
//
//  Created by Jimmy on 4/25/17.
//  Copyright © 2017 teddy-jimmy. All rights reserved.
//

import UIKit

class PersonalControllerViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    var topHits : [String] = []
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidLoad()
        let k = currentUserWordCount
        print("???")
        print(k.flatMap({$0}).sorted { $0.0.1 < $0.1.1 })
        topHits = Array(currentUserWordCount.keys)
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return topHits.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "topHitCell", for: indexPath) as! TopHitCell
        cell.topWord.text = topHits[indexPath.row]
        return cell
        
        
    }

    



}
