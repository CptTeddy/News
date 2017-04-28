//
//  constantModel.swift
//  news
//
//  Created by Jimmy on 4/5/17.
//  Copyright © 2017 teddy-jimmy. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase
import FirebaseAuth



let KEY = "09198f4fbe3e46b6b4585afce93a0542"

let feedCatalog = ["General", "Technology", "Business", "Sport", "Politics", "Entertainment", "Music", "Science", "gaming"]

let recommendNumber = 25

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

let neturalWords =  [
"a",
"a's",
"able",
"about",
"above",
"according",
"accordingly",
"across",
"actually",
"after",
"afterwards",
"again",
"against",
"ain't",
"all",
"allow",
"allows",
"almost",
"alone",
"along",
"already",
"also",
"although",
"always",
"am",
"among",
"amongst",
"an",
"and",
"another",
"any",
"anybody",
"anyhow",
"anyone",
"anything",
"anyway",
"anyways",
"anywhere",
"apart",
"appear",
"appreciate",
"appropriate",
"are",
"aren't",
"around",
"as",
"aside",
"ask",
"asking",
"associated",
"at",
"available",
"away",
"awfully",
"b",
"be",
"became",
"because",
"become",
"becomes",
"becoming",
"been",
"before",
"beforehand",
"behind",
"being",
"believe",
"below",
"beside",
"besides",
"best",
"better",
"between",
"beyond",
"both",
"brief",
"but",
"by",
"c",
"c'mon",
"c's",
"came",
"can",
"can't",
"cannot",
"cant",
"cause",
"causes",
"certain",
"certainly",
"changes",
"clearly",
"co",
"com",
"come",
"comes",
"concerning",
"consequently",
"consider",
"considering",
"contain",
"containing",
"contains",
"corresponding",
"could",
"couldn't",
"course",
"currently",
"d",
"definitely",
"described",
"despite",
"did",
"didn't",
"different",
"do",
"does",
"doesn't",
"doing",
"don't",
"done",
"down",
"downwards",
"during",
"e",
"each",
"edu",
"eg",
"eight",
"either",
"else",
"elsewhere",
"enough",
"entirely",
"especially",
"et",
"etc",
"even",
"ever",
"every",
"everybody",
"everyone",
"everything",
"everywhere",
"ex",
"exactly",
"example",
"except",
"f",
"far",
"few",
"fifth",
"first",
"five",
"followed",
"following",
"follows",
"for",
"former",
"formerly",
"forth",
"four",
"from",
"further",
"furthermore",
"g",
"get",
"gets",
"getting",
"given",
"gives",
"go",
"goes",
"going",
"gone",
"got",
"gotten",
"greetings",
"h",
"had",
"hadn't",
"happens",
"hardly",
"has",
"hasn't",
"have",
"haven't",
"having",
"he",
"he's",
"hello",
"help",
"hence",
"her",
"here",
"here's",
"hereafter",
"hereby",
"herein",
"hereupon",
"hers",
"herself",
"hi",
"him",
"himself",
"his",
"hither",
"hopefully",
"how",
"howbeit",
"however",
"i",
"i'd",
"i'll",
"i'm",
"i've",
"ie",
"if",
"ignored",
"immediate",
"in",
"inasmuch",
"inc",
"indeed",
"indicate",
"indicated",
"indicates",
"inner",
"insofar",
"instead",
"into",
"inward",
"is",
"isn't",
"it",
"it'd",
"it'll",
"it's",
"its",
"itself",
"j",
"just",
"k",
"keep",
"keeps",
"kept",
"know",
"knows",
"known",
"l",
"last",
"lately",
"later",
"latter",
"latterly",
"least",
"less",
"lest",
"let",
"let's",
"like",
"liked",
"likely",
"little",
"look",
"looking",
"looks",
"ltd",
"m",
"mainly",
"many",
"may",
"maybe",
"me",
"mean",
"meanwhile",
"merely",
"might",
"more",
"moreover",
"most",
"mostly",
"much",
"must",
"my",
"myself",
"n",
"name",
"namely",
"nd",
"near",
"nearly",
"necessary",
"need",
"needs",
"neither",
"never",
"nevertheless",
"new",
"next",
"nine",
"no",
"nobody",
"non",
"none",
"noone",
"nor",
"normally",
"not",
"nothing",
"novel",
"now",
"nowhere",
"o",
"obviously",
"of",
"off",
"often",
"oh",
"ok",
"okay",
"old",
"on",
"once",
"one",
"ones",
"only",
"onto",
"or",
"other",
"others",
"otherwise",
"ought",
"our",
"ours",
"ourselves",
"out",
"outside",
"over",
"overall",
"own",
"p",
"particular",
"particularly",
"per",
"perhaps",
"placed",
"please",
"plus",
"possible",
"presumably",
"probably",
"provides",
"q",
"que",
"quite",
"qv",
"r",
"rather",
"rd",
"re",
"really",
"reasonably",
"regarding",
"regardless",
"regards",
"relatively",
"respectively",
"right",
"s",
"said",
"same",
"saw",
"say",
"saying",
"says",
"second",
"secondly",
"see",
"seeing",
"seem",
"seemed",
"seeming",
"seems",
"seen",
"self",
"selves",
"sensible",
"sent",
"serious",
"seriously",
"seven",
"several",
"shall",
"she",
"should",
"shouldn't",
"since",
"six",
"so",
"some",
"somebody",
"somehow",
"someone",
"something",
"sometime",
"sometimes",
"somewhat",
"somewhere",
"soon",
"sorry",
"specified",
"specify",
"specifying",
"still",
"sub",
"such",
"sup",
"sure",
"t",
"t's",
"take",
"taken",
"tell",
"tends",
"th",
"than",
"thank",
"thanks",
"thanx",
"that",
"that's",
"thats",
"the",
"their",
"theirs",
"them",
"themselves",
"then",
"thence",
"there",
"there's",
"thereafter",
"thereby",
"therefore",
"therein",
"theres",
"thereupon",
"these",
"they",
"they'd",
"they'll",
"they're",
"they've",
"think",
"third",
"this",
"thorough",
"thoroughly",
"those",
"though",
"three",
"through",
"throughout",
"thru",
"thus",
"to",
"together",
"too",
"took",
"toward",
"towards",
"tried",
"tries",
"truly",
"try",
"trying",
"twice",
"two",
"u",
"un",
"under",
"unfortunately",
"unless",
"unlikely",
"until",
"unto",
"up",
"upon",
"us",
"use",
"used",
"useful",
"uses",
"using",
"usually",
"uucp",
"v",
"value",
"various",
"very",
"via",
"viz",
"vs",
"w",
"want",
"wants",
"was",
"wasn't",
"way",
"we",
"we'd",
"we'll",
"we're",
"we've",
"welcome",
"well",
"went",
"were",
"weren't",
"what",
"what's",
"whatever",
"when",
"whence",
"whenever",
"where",
"where's",
"whereafter",
"whereas",
"whereby",
"wherein",
"whereupon",
"wherever",
"whether",
"which",
"while",
"whither",
"who",
"who's",
"whoever",
"whole",
"whom",
"whose",
"why",
"will",
"willing",
"wish",
"with",
"within",
"without",
"won't",
"wonder",
"would",
"would",
"wouldn't",
"x",
"y",
"yes",
"yet",
"you",
"you'd",
"you'll",
"you're",
"you've",
"your",
"yours",
"yourself",
"yourselves",
"z",
"zero"
]

let catalogColor:[Int:[Float]] = [
    0: [20, 20, 40],
    1: [0, 100, 0],
    2: [0, 0, 100],
    3: [200, 0, 0],
    4: [0, 200, 0],
    5: [0, 0, 200],
    6: [160, 160, 0],
    7: [0, 160, 160],
    8: [0, 200, 0],
]
