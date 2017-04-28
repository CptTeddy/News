
//
//  AccessFireBaseModel.swift
//  news
//
//  Created by Jimmy on 4/13/17.
//  Copyright © 2017 teddy-jimmy. All rights reserved.
//

import Foundation
import FirebaseDatabase
import FirebaseAuth
import Alamofire
import SwiftyJSON

//var localWordFreq = {}
//var localCatagoryFreq = {}
//let firUser = "firUser"
//let firWord = "firWord"
//let firCategory = "firCategory"
//let firWordFreq = "firWordFreq"
//let firCategoryFreq = "firCategoryFreq"

var currentUserWordCount = [String: Int]()
var currentUserCategoryCount = [String: Int]()
var newsData = [String:[News]]()
var sortedScore = [(News,Int)]()
var readNewses = [News]()


func updateNewsLocal(newsTitle: String, category:String, upvote: Bool){
    
    let wordList = newsTitle.components(separatedBy: " ")
    for word in wordList{
        if !neturalWords.contains(word){
            if currentUserWordCount[word] == nil{
                currentUserWordCount[word] = 0
            }
            if upvote{
                currentUserWordCount[word]! += 1
            }else{
                currentUserWordCount[word]! -= 1
            }
        }
    }
    if currentUserCategoryCount[category] == nil{
        currentUserCategoryCount[category] = 0
    }
    if upvote{
        currentUserCategoryCount[category]! += 1
    }else{
        currentUserCategoryCount[category]! -= 1
    }
}

func uploadReadNews(news: News, userId: String){
    let dbRef = FIRDatabase.database().reference()
    dbRef.child(userId).child("readNews").child(news.title!).child("title").setValue(news.title)
    dbRef.child(userId).child("readNews").child(news.title!).child("author").setValue(news.author)
    dbRef.child(userId).child("readNews").child(news.title!).child("description").setValue(news.description)
    dbRef.child(userId).child("readNews").child(news.title!).child("url").setValue(news.url)
    dbRef.child(userId).child("readNews").child(news.title!).child("urlToImage").setValue(news.urlToImage)
    dbRef.child(userId).child("readNews").child(news.title!).child("publishedAt").setValue(news.publishedAt)
}

func downloadReadNews(userId: String){
    readNewses = [News]()

    let dbRef = FIRDatabase.database().reference()
    dbRef.child(userId).child("readNews").observe(.value, with: { (readNews) in
        if readNews.exists() {
            if let pair = readNews.value as? [String: AnyObject] {
                for (title,values) in pair {
                    var news = News()
                    print(values)
                    
                    if let values = values as? [String: AnyObject] {
                        for (attribute, value) in values {
                            switch attribute {
                                case "author":
                                    news.author = value as! String
                                    print(value)
                                    print(news.author)
                                case "title":
                                    news.title = value as! String
                                case "description":
                                    news.description = value as! String
                                case "url":
                                    news.url = value as! String
                                case "urlToImage":
                                    news.urlToImage = value as! String
                                case "publishedAt":
                                    news.publishedAt = value as! String

                                
                                default:
                                    print("")
                                
                            }
                        }
                    }
                    readNewses.append(news)
                    print(readNewses.count)
                    
                }
                let notificationKey = "finishedDownloadReadNews"
                
                NotificationCenter.default.post(name: Notification.Name(rawValue: notificationKey), object: nil)
            }
        }
        
    })

}

func convertToDictionary(text: String) -> [String: Any]? {
    if let data = text.data(using: .utf8) {
        do {
            return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
        } catch {
            print(error.localizedDescription)
        }
    }
    return nil
}



func downloadUserData(userId: String){
    let dbRef = FIRDatabase.database().reference()
    dbRef.child(userId).child("wordCount").observe(.value, with: { (wordData) in
        if wordData.exists() {
            if let wordDict = wordData.value as? [String: AnyObject] {
                for (key,value) in wordDict {
                    let count = Int(value as! NSNumber)
                    currentUserWordCount[key] = count
                }
                let notificationKey = "finishedDownloadWordCount"
                
                NotificationCenter.default.post(name: Notification.Name(rawValue: notificationKey), object: nil)
            }
        }
        
    })
    dbRef.child(userId).child("categoryCount").observe(.value, with: { (categoryData) in
        if categoryData.exists() {
            if let catDict = categoryData.value as? [String: AnyObject] {
                for (key,value) in catDict {
                    let count = Int(value as! NSNumber)
                    currentUserCategoryCount[key] = count
                }
            }
        }
        
    })
    let downloadNotificationKey = "finishedDownload"
    NotificationCenter.default.post(name: Notification.Name(rawValue: downloadNotificationKey), object: nil)
}

func uploadUserData(userId: String){
    let dbRef = FIRDatabase.database().reference()
    for (word,count) in currentUserWordCount{
        dbRef.child(userId).child("wordCount").child(word).setValue(count)
    }
    for (cat,count) in currentUserCategoryCount{
        dbRef.child(userId).child("categoryCount").child(cat).setValue(count)
    }
    
}





func fetchNews(){
    for (cat,resources) in catalogSource{
        for resource in resources as [String]{
            let url = "https://newsapi.org/v1/articles?source="+resource+"&sortBy=top&apiKey="+KEY;
            Alamofire.request(url).responseJSON(completionHandler: { response in
                if response.result.isFailure {
                    print("failed")
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
                    var newsLst = newsData[cat]
                    if newsLst == nil {
                        var lst = [News]()
                        newsData[cat] = lst
                    }
                    newsLst = newsData[cat]
                    newsData[cat]! += [news]
                    
                }
                let notificationKey = "finishedSorting"

                NotificationCenter.default.post(name: Notification.Name(rawValue: notificationKey), object: nil)
            })
        }
    }
}


