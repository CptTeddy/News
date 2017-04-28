//
//  newsListUIViewController.swift
//  news
//
//  Created by Jimmy on 4/5/17.
//  Copyright © 2017 teddy-jimmy. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import FirebaseAuth


class newsListUIViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate {
    
    var catalogName:String?
    var feedArray:[News] = [News]()
    

    @IBOutlet weak var newsTableView: UITableView!
    var refreshControl = UIRefreshControl()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(newsListUIViewController.swiped(swipeGesture:)))
        newsTableView.addGestureRecognizer(swipeGesture)
        swipeGesture.delegate = self as! UIGestureRecognizerDelegate
        
        newsTableView.delegate = self
        let notificationKey = "finishedSorting"
        newsTableView.dataSource = self
        if let newsData = newsData[catalogName!]{
            feedArray = newsData

        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(newsListUIViewController.reloadView), name: NSNotification.Name(rawValue: notificationKey), object: nil)
        
        
        newsTableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(self.refreshData), for: .valueChanged)
        
        // Do any additional setup after loading the view.
    }
    
    func refreshData(){
        newsTableView.reloadData()
        print("reloading")
        fetchNews()
        refreshControl.endRefreshing()
    }
    
    func swiped(swipeGesture: UISwipeGestureRecognizer)  {
        if let swipeGesture = swipeGesture as? UISwipeGestureRecognizer{
            switch swipeGesture.direction {
                case UISwipeGestureRecognizerDirection.right:
                    print("right swipe")
                    let swipeLocation = swipeGesture.location(in: self.newsTableView)
                    if let swipeIndexPath = self.newsTableView.indexPathForRow(at: swipeLocation) {
                        if let swipedCell = self.newsTableView.cellForRow(at: swipeIndexPath) as? newsTableViewCell {
                            swipedCell.removeFromSuperview()
                            print("correct swipe")
                        }
                    }
                default:
                    print("other swipes")
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feedArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "newsCell") as! newsTableViewCell
        cell.newsTitle.text = feedArray[indexPath.row].title
        Alamofire.request(feedArray[indexPath.row].urlToImage!).responseData(completionHandler: { response in
            if let data = response.result.value {
                cell.newsImage.image = UIImage(data: data)
            }
        })
        return cell

    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let title = feedArray[indexPath.row].title
        if FIRAuth.auth()?.currentUser != nil {
            let id = FIRAuth.auth()?.currentUser?.uid
            downloadUserData(userId: id!)
            uploadReadNews(news: feedArray[indexPath.row], userId: id!)
            downloadReadNews(userId: id!)
            
        }

        performSegue(withIdentifier: "newsListToNewsWeb", sender: self.feedArray[indexPath.row])
        
        updateNewsLocal(newsTitle: title!, category:self.catalogName!, upvote: true)
        
    }
    

    
    func reloadView() {
        feedArray = newsData[catalogName!]!
        self.newsTableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? newsWebUIVIewController {
            if let sender = sender{
                let news = sender as! News
                destinationVC.url = news.url!
            }
        }
    }
    
    
    
    

}
