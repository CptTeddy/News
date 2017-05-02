//
//  RecommendViewController.swift
//  news
//
//  Created by Jimmy on 4/18/17.
//  Copyright © 2017 teddy-jimmy. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import Alamofire
import SwiftyJSON

class RecommendViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var deletedRowsNumber = 0
    var catalogName:String?
    var feedArray:[News] = [News]()
    
    var refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let currentUser = FIRAuth.auth()?.currentUser
        let id = currentUser?.uid
        downloadUserData(userId: id!)
        sortModel().startSortNews()
        recommendNewsTableViews.delegate = self
        recommendNewsTableViews.dataSource = self
        let finishSortSignal = "finished sorting"
        NotificationCenter.default.addObserver(self, selector: #selector(RecommendViewController.reloadView), name: NSNotification.Name(rawValue: finishSortSignal), object: nil)
        // Do any additional setup after loading the view.
        
        recommendNewsTableViews.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(self.refreshData), for: .valueChanged)
        
    }
    
    func refreshData(){
        fetchNews()
        var i = 0
        while i < 5 {
            sortedScore.remove(at: 0)
            i += 1
        }
        self.recommendNewsTableViews.reloadData()
        refreshControl.endRefreshing()
    }
    
    @IBOutlet weak var recommendNewsTableViews: UITableView!

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recommendNumber - deletedRowsNumber
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    @objc func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "Dislike" //or customize for each indexPath
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            sortedScore.remove(at: 2)
            deletedRowsNumber += 1
            recommendNewsTableViews.deleteRows(at: [indexPath], with: .fade)
            
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "newsCell") as! recommendNewsTableViewCell
        cell.newsTitle.text = sortedScore[indexPath.row].0.title
        cell.newsImage.image = nil
        Alamofire.request(sortedScore[indexPath.row].0.urlToImage!).responseData(completionHandler: { response in
            if let data = response.result.value {
                cell.newsImage.image = UIImage(data: data)
            }else{
                cell.newsImage.image = nil            }
        })
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "recommendToNewsWeb", sender: sortedScore[indexPath.row].0)
        let title = sortedScore[indexPath.row].0.title
//        updateNewsLocal(newsTitle: title!, category:self.catalogName!, upvote: true)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? recommendWebViewController {
            if let sender = sender{
                let news = sender as! News
                destinationVC.url = news.url!
            }
        }
    }

    
    
    func reloadView() {
        self.recommendNewsTableViews.reloadData()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
