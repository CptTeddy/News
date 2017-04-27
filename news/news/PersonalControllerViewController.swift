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
class PersonalControllerViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBAction func logOut(_ sender: Any) {
        let firebaseAuth = FIRAuth.auth()
        do {
            try firebaseAuth?.signOut()
            self.performSegue(withIdentifier: "personalToLogin", sender: self)
            
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var topHitsCollectionView: UICollectionView!
    var topHits : [String] = []
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidLoad()
        print(currentUserWordCount.flatMap({$0}).sorted { $0.0.1 > $0.1.1 })
        topHits = Array(currentUserWordCount.keys)
        if FIRAuth.auth()?.currentUser != nil {
            let email = FIRAuth.auth()?.currentUser?.email
            self.username.text = email
        }

        


        
        
        

    }
    
    override func viewDidLoad() {
        let notificationKey = "finishedDownloadWordCount"
        topHitsCollectionView.delegate = self
        topHitsCollectionView.dataSource = self

        NotificationCenter.default.addObserver(self, selector: #selector(PersonalControllerViewController.reloadTopView), name: NSNotification.Name(rawValue: notificationKey), object: nil)
    }
    
    func reloadTopView(){
        print(currentUserWordCount.flatMap({$0}).sorted { $0.0.1 > $0.1.1 })
        topHits = Array(currentUserWordCount.keys)
        topHits = Array(topHits[0...10])
        topHitsCollectionView.reloadData()
        
        
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
