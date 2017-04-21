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

class newsListUIViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var catalogName:String?
    var feedArray:[News] = [News]()
    

    @IBOutlet weak var newsTableView: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newsTableView.delegate = self
        let notificationKey = "finishedSorting"
        newsTableView.dataSource = self
        makeRequest(newsCatelog: self.catalogName!)
        NotificationCenter.default.addObserver(self, selector: #selector(newsListUIViewController.reloadView), name: NSNotification.Name(rawValue: notificationKey), object: nil)


        // Do any additional setup after loading the view.
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
        performSegue(withIdentifier: "newsListToNewsWeb", sender: self.feedArray[indexPath.row])
        let title = feedArray[indexPath.row].title
        updateNewsLocal(newsTitle: title!, category:self.catalogName!, upvote: true)
    }
    
    func makeRequest(newsCatelog: String){
<<<<<<< HEAD
        let APIsources = catalogSource[newsCatelog]
        for APIsource in APIsources!{
            let url = "https://newsapi.org/v1/articles?source="+APIsource+"&sortBy=top&apiKey="+KEY;
            Alamofire.request(url).responseJSON(completionHandler: { response in
                if response.result.isFailure {
                    return
                }
                
                
                var articles = JSON(response.data!)["articles"]
                for var articleTuple in articles{
                    var article = articleTuple.1
                    var news = News(author:article["article"].stringValue,
                                    title: article["title"].stringValue,
                                    description: article["description"].stringValue,
                                    url: article["url"].stringValue,
                                    urlToImage: article["urlToImage"].stringValue,
                                    publishedAt: article["publishedAt"].stringValue)
                    self.feedArray.append(news)
                    
                }
                
                self.newsTableView.reloadData()
                
            })
=======
        let newses = newsData[newsCatelog]
        for var news in newses!{
                self.feedArray.append(news)
            
>>>>>>> aa0a25e90ebc1bddd51e6ceee066d76498ca8422
        }
        self.newsTableView.reloadData()

    }
    
    func reloadView() {
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
