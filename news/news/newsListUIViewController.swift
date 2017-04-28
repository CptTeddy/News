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


class newsListUIViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var catalogName:String?
    var feedArray:[News] = [News]()
    

    @IBOutlet weak var newsTableView: UITableView!
    var refreshControl = UIRefreshControl()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var tapGesture = UITapGestureRecognizer(target: self, action: #selector(newsListUIViewController.tapEdit(_:)))
        newsTableView.addGestureRecognizer(tapGesture!)
        tapGesture!.delegate = self
        
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
    
    func tapEdit(recognizer: UITapGestureRecognizer)  {
        if recognizer.state == UIGestureRecognizerState.ended {
            let tapLocation = recognizer.location(in: self.newsTableView)
            if let tapIndexPath = self.newsTableView.indexPathForRow(at: tapLocation) {
                if let tappedCell = self.newsTableView.cellForRow(at: tapIndexPath) as? newsTableViewCell {
                    //do what you want to cell here
                    
                }
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
            print("download")
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
