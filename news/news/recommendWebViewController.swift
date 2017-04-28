//
//  recommendWebViewController.swift
//  news
//
//  Created by Jimmy on 4/27/17.
//  Copyright © 2017 teddy-jimmy. All rights reserved.
//

import UIKit

class recommendWebViewController: UIViewController {

    @IBOutlet weak var newWebView: UIWebView!
    var url = "google.com"
    override func viewDidLoad() {
        
        super.viewDidLoad()
        let requestURL = NSURL(string: url)
        let request = URLRequest(url: requestURL as! URL)
        newWebView.loadRequest(request)


        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
