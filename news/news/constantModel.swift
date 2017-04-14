//
//  constantModel.swift
//  news
//
//  Created by Jimmy on 4/5/17.
//  Copyright © 2017 teddy-jimmy. All rights reserved.
//

import Foundation

let feedCatalog = ["General", "Technology", "Business", "Sport", "Politics", "Entertainment", "Music", "Science", "gaming"]

let catalogSource:[String:[String]] = ["General": ["abc-news-au","associated-press","al-jazeera-english", "bbc-news",
                                                   "bild","cnn", "der-tagesspiegel", "focus", "football-italia",
                                                    "google-news", "independent", "metro", "mirror", "newsweek",
                                                    "new-york-magazine", "reddit-r-all", "reuters", "spiegel-online","the-guardian-au", "the-guardian-uk", "the-hindu", "the-huffington-post", "the-new-york-times", "the-telegraph", "the-times-of-india", "the-wall-street-journal", "the-washington-post", "time", "usa-today", "wired-de"],
                                       "Technology":["ars-technica", "engadget", "gruenderszene", "hacker-news", "recode", "t3n",
                                                        "talksport", "techcrunch", "techradar", "the-next-web", "the-verge"],
                                       "Business":["bloomberg", "business-insider", "business-insider-uk", "cnbc", "die-zeit", "financial-times", "fortune","handelsblatt", "the-economist", "wirtschafts-woche"],
                                       "Politics":["breitbart-news"],
                                       "Entertainment":["buzzfeed", "daily-mail","entertainment-weekly", "mashable", "the-lad-bible", ],
                                       "Music":["mtv-news", "mtv-news-uk"],
                                       "Science":["new-scientist", "national-geographic"],
                                       "gaming":["polygon","ign"],
                                       "Sport":["espn", "bbc-sport","espn-cric-info", "four-four-two","fox-sports", "nfl-news", "the-sport-bible"]]
                                       
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
