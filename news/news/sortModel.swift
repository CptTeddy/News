//
//  sortModel.swift
//  news
//
//  Created by ZhangJianglai on 4/25/17.
//  Copyright © 2017 teddy-jimmy. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase
import FirebaseAuth
import Alamofire

class sortModel {

    init() {
        let downloadNotificationKey = "finishedDownload"
        NotificationCenter.default.addObserver(self, selector: #selector(sortModel.startSortNews), name: NSNotification.Name(rawValue: downloadNotificationKey), object: nil)
    }
    
    @objc func startSortNews() {
        var userWordCount = currentUserWordCount
        var userCategoryCount = currentUserCategoryCount
        var news = newsData
        // Till this point all data (news and users') should have been loaded if there is any.
        var newsScore = [(News, Int)]()
        for eachType in news.values {
            for eachNews in eachType {
                var itsScore = 0 // Weighing.
                newsScore.append((eachNews, itsScore))
            }
        }
        newsScore.sort(by: {$0.1>$1.1})
        sortedScore = newsScore
//        var sortedNewsScore = newsScore.sortedArrayUsingComparator {
//            (tuple1, tuple2) -> ComparisonResult in
//            
//            let result = tuple1[1].compare(tuple2[1])
//            return result
//        }
//        var sortedNewsScore = [News:Int]()
//        for (news,score) in (Array(newsScore).sorted {$0.1 > $1.1}) {
//            sortedNewsScore[news] = score
//        }
    }
}

