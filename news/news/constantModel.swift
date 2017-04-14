//
//  constantModel.swift
//  news
//
//  Created by Jimmy on 4/5/17.
//  Copyright © 2017 teddy-jimmy. All rights reserved.
//

import Foundation

let feedCatalog = ["General", "Technology", "Business", "Politics", "Entertainment", "Music", "Science", "gaming"]

let catalogSource:[String:[String]] = ["General": ["abc-news-au","associated-press","al-jazeera-english"],
                                       "Technology":["ars-technica"],
                                       "Business":["bloomberg"],
                                       "Politics":["breitbart-news"],
                                       "Entertainment":["buzzfeed"],
                                       "Music":["mtv-news"],
                                       "Science":["new-scientist"],
                                       "gaming":["polygon"]]
                                       
let catalogColor:[Int:[Float]] = [
    0: [20, 20, 40],
    1: [0, 100, 0],
    2: [0, 0, 100],
    3: [200, 0, 0],
    4: [0, 200, 0],
    5: [0, 0, 200],
    6: [160, 160, 0],
    7: [0, 160, 160]
]


                                       
    

