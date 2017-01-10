//
//  LoginViewController.swift
//  DevChat
//
//  Created by Alfonso, Hector I. on 12/29/16.
//  Copyright © 2016 Alfonso, Hector I. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {

    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    @IBAction func loginPressed(sender: UIButton) {
        if let email = emailTextField.text, let password = passwordTextField.text, email.characters.count > 0, password.characters.count > 0 {
            
            
            AuthService.instance.login(withEmail: email, password: password, completion: { (message, data) in
                guard message == nil else {
                    let alert = UIAlertController(title: "Error Authenticating", message: message, preferredStyle: .alert)
                    let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alert.addAction(action)
                    self.present(alert, animated: true, completion: nil)
                    return
                }
                
                self.dismiss(animated: true, completion: nil)
            })
    
        }
        else {
            let alert = UIAlertController(title: "User name and password required", message: "You must enter both a user name and password", preferredStyle: .alert)
            
            let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            
            alert.addAction(action)
            
            present(alert, animated: true, completion: nil)
        }
    }
 

}
