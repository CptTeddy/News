//
//  PersonalControllerViewController.swift
//  news
//
//  Created by Jimmy on 4/25/17.
//  Copyright © 2017 teddy-jimmy. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import Alamofire

class PersonalControllerViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBAction func logOut(_ sender: Any) {
        let firebaseAuth = FIRAuth.auth()
        do {
            try firebaseAuth?.signOut()
            currentUserWordCount = [String: Int]()
            currentUserCategoryCount = [String: Int]()
            readNewses = [News]()
            sortedScore = [(News,Int)]()
            self.performSegue(withIdentifier: "personalToLogin", sender: self)
            
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var topHitsCollectionView: UICollectionView!
    
    @IBOutlet weak var readNewsCollectionView: UICollectionView!
    
    var topHits : [String] = []
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidLoad()
//        print(currentUserWordCount.flatMap({$0}).sorted { $0.0.1 > $0.1.1 })
        topHits = Array(currentUserWordCount.keys)
        if FIRAuth.auth()?.currentUser != nil {
            let email = FIRAuth.auth()?.currentUser?.email
            self.username.text = email
            let id = FIRAuth.auth()?.currentUser?.uid

            
        }
        topHitsCollectionView.reloadData()
        

        


        
        
        

    }
    
    override func viewDidLoad() {
        let notificationKey = "finishedDownloadWordCount"
        topHitsCollectionView.delegate = self
        topHitsCollectionView.dataSource = self
        readNewsCollectionView.delegate = self
        readNewsCollectionView.dataSource = self


        NotificationCenter.default.addObserver(self, selector: #selector(PersonalControllerViewController.reloadTopView), name: NSNotification.Name(rawValue: notificationKey), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(PersonalControllerViewController.reloadReadNews), name: NSNotification.Name(rawValue: "finishedDownloadReadNews"), object: nil)
    }
    
    func reloadTopView(){
//        print(currentUserWordCount.flatMap({$0}).sorted { $0.0.1 > $0.1.1 })
        topHits = Array(currentUserWordCount.keys)
        topHits = Array(topHits[0...min(10, topHits.count)])
        topHitsCollectionView.reloadData()
        
        
    }
    
    func reloadReadNews(){
        readNewsCollectionView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == topHitsCollectionView{
            return topHits.count
        }else{
            return readNewses.count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == topHitsCollectionView{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "topHitCell", for: indexPath) as! TopHitCell
            cell.topWord.text = topHits[indexPath.row]
            cell.topWord.sizeToFit()
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "readNewsCell", for: indexPath) as! ReadNewsCell
            let currentNews = readNewses[indexPath.row]
            if let imageURL = currentNews.urlToImage{
                Alamofire.request(imageURL).responseData(completionHandler: { response in
                    if let data = response.result.value {
                        cell.newsImage.image = UIImage(data: data)
                    }
                })
            }


            cell.newsTitle.text = currentNews.title
            return cell
        }
        
        
    }

    



}
