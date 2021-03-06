//
//  FeedListViewController.swift
//  news
//
//  Created by Jimmy on 4/5/17.
//  Copyright © 2017 teddy-jimmy. All rights reserved.
//

import UIKit

class FeedListViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var catalogCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        catalogCollectionView.delegate = self
        catalogCollectionView.dataSource = self




        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return feedCatalog.count
        
    }
    

    //MARK: - UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenSize: CGRect = UIScreen.main.bounds
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        return CGSize(width: screenWidth/2.1, height: 1.1 * screenWidth/2.1)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "catalogCell", for: indexPath) as! feedListCollectionViewCell
        cell.catalogName.text = feedCatalog[indexPath.row]
        cell.catalogImageView.image = UIImage(named: feedCatalog[indexPath.row])
        
        cell.catalogImageView.layer.cornerRadius =  cell.catalogImageView.frame.size.width/2
        cell.catalogImageView.clipsToBounds = true
        //  cell.catalogName.backgroundColor = UIColor.init(colorLiteralRed: (catalogColor[indexPath.item]?[0])!, green: (catalogColor[indexPath.item]?[1])!, blue: (catalogColor[indexPath.item]?[2])!, alpha: 50)
        return cell
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "catalogToList", sender: feedCatalog[indexPath.row])
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? newsListUIViewController {
            if let sender = sender{
                let catalogName = sender as! String
                destinationVC.catalogName = catalogName
            }
        }
    }


}
