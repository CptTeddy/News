//
//  SignUpViewController.swift
//  news
//
//  Created by Jimmy on 4/13/17.
//  Copyright © 2017 teddy-jimmy. All rights reserved.
//

import UIKit
import Firebase

class SignUpViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        name.delegate = self
        email.delegate = self
        password.delegate = self

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func trySignUp(_ sender: Any) {
        guard let email = email.text else { return }
        guard let password = password.text else { return }
        guard let name = name.text else { return }
        FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: {
            (user,error) in
            if let error = error{
                print(error)
                let alert = UIAlertController(title: "Log in fail", message: error.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "okay", style: UIAlertActionStyle.default, handler: { (action) in
                    
                }))
                self.present(alert, animated: true, completion: nil)
                
            }else{
                let changeRequest = user!.profileChangeRequest()
                changeRequest.displayName = name
                changeRequest.commitChanges(completion: {
                    (err) in
                    if let err = err{
                        
                    }else{
                        
                    }
                    
                })
                
            }
            
        })
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
