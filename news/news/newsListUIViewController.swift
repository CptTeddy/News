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
        newsTableView.dataSource = self
        makeRequest(newsCatelog: self.catalogName!)


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
        let newses = newsData[newsCatelog]
        for var news in newses!{
                self.feedArray.append(news)
            
        }
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
