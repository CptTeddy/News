//
//  News.swift
//  news
//
//  Created by Jimmy on 4/6/17.
//  Copyright © 2017 teddy-jimmy. All rights reserved.
//

import Foundation

class News{
    var author: String?
    var title: String?
    var description: String?
    var url: String?
    var urlToImage: String?
    var publishedAt: String?
    
    init(author: String?, title: String?, description: String?, url: String?, urlToImage: String?, publishedAt: String?){
        self.author = author
        self.title = title
        self.description = description
        self.url = url
        self.urlToImage = urlToImage
        self.publishedAt = publishedAt
    }
    
    init(){
        
    }
}
