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

func downloadUserData(userId: String){
    let dbRef = FIRDatabase.database().reference()
    dbRef.child(userId).child("wordCount").observe(.value, with: { (wordData) in
        if wordData.exists() {
            if let wordDict = wordData.value as? [String: AnyObject] {
                for (key,value) in wordDict {
                    let count = Int(value as! NSNumber)
                    currentUserWordCount[key] = count
                }
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
    for (cats,resources) in catalogSource{
        for resource in resources as [String]{
            let url = "https://newsapi.org/v1/articles?source="+resource+"&sortBy=top&apiKey="+KEY;
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
                    var newsLst = newsData[resource]
                    newsLst!.append(news)
                }
            })
        }
    }
}
