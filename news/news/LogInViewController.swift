//
//  LogInViewController.swift
//  news
//
//  Created by Jimmy on 4/13/17.
//  Copyright © 2017 teddy-jimmy. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth



class LogInViewController: UIViewController {

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // Checks if user is already signed in and skips login
        if FIRAuth.auth()?.currentUser != nil {
            let id = FIRAuth.auth()?.currentUser?.uid
            downloadUserData(userId: id!)
            downloadReadNews(userId: id!)
            
        }
        if FIRAuth.auth()?.currentUser != nil {
            self.performSegue(withIdentifier: "loginToMain", sender: self)
        }
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func tryLogIn(_ sender: Any) {
        guard let emailText = email.text else { return }
        guard let passwordText = password.text else { return }
        
        // YOUR CODE HERE
        FIRAuth.auth()?.signIn(withEmail: emailText, password: passwordText, completion: {(user, error) in
            if let error = error {
                let alert = UIAlertController(title: "Sign in failed. Please try again!", message: error.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "huh okay", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            } else {
                self.performSegue(withIdentifier: "loginToMain", sender: self)
                let currentUser = FIRAuth.auth()?.currentUser
                let id = currentUser?.uid
                downloadUserData(userId: id!)
                downloadReadNews(userId: id!)
            }
//            let downloadNotificationKey = "finishedDownload"
//            NotificationCenter.default.post(name: Notification.Name(rawValue: downloadNotificationKey), object: self)
        })

    }

    @IBAction func goToSignUp(_ sender: Any) {
        self.performSegue(withIdentifier: "LogInToSignUp", sender: self)
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
