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

func sortNews() {
    let downloadNotificationKey = "finishedDownload"
    NotificationCenter.default.addObserver(self, selector: startSortNews, name: NSNotification.Name(rawValue: downloadNotificationKey), object: nil)
}

func startSortNews() {
    var userWordCount = currentUserWordCount
    var userCategoryCount = currentUserCategoryCount
    var news = newsData
    // Till this point all data (news and users') should have been loaded if there is any.
}

