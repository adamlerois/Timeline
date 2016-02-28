//
//  LoginSignupViewController.swift
//  Timeline
//
//  Created by youcef bouhafna on 2/23/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import UIKit

class LoginSignupViewController: UIViewController {
    var user: User?
    
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var bioTextField: UITextField!
    @IBOutlet weak var urlTextField: UITextField!
    @IBOutlet weak var actionButton: UIButton!
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // computed property
    var fieldsAreValid: Bool {
        get {
            switch mode {
            case .Login:
                return  !(emailTextField.text!.isEmpty  || passwordTextField.text!.isEmpty)
            case .Signup:
                return !(emailTextField.text!.isEmpty || passwordTextField.text!.isEmpty || userNameTextField.text!.isEmpty)
                
            case .Edit:
                return !(userNameTextField.text!.isEmpty)
            }
            
        }
        
    }

    
    
    enum ViewMode {
        case Login
        case Signup
        case Edit
    }
    var mode = ViewMode.Signup
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViewBasedOnMode()
    }
    func updateViewBasedOnMode() {
        switch mode {
        case .Signup:
            self.userNameTextField.hidden = false
            self.passwordTextField.hidden = false
            self.bioTextField.hidden = false
            self.urlTextField.hidden = false
            self.emailTextField.hidden = false
            actionButton.setTitle("SignUp", forState: .Normal)
        case .Login :
            self.emailTextField.hidden = false
            self.passwordTextField.hidden = false
            self.userNameTextField.hidden = true
            self.bioTextField.hidden = true
            self.urlTextField.hidden = true
            actionButton.setTitle("LogIn", forState: .Normal)
        case .Edit:
            self.emailTextField.hidden = true
            self.passwordTextField.hidden = true
            actionButton.setTitle("Edit", forState: .Normal)
            if let user = user {
                userNameTextField.text = user.userName
                bioTextField.text = user.bio
                urlTextField.text = user.url
                
            }
        }
        
    }
    
    
    @IBAction func actionButtonTapped(sender: AnyObject) {
        if fieldsAreValid {
            switch mode {
            case .Login:
                UserController.authenticateUser(emailTextField.text!, password: passwordTextField.text!, completion: { (success, user) -> Void in
                if  success, let _ = user {
                    self.dismissViewControllerAnimated(true, completion: nil)
                }else {
                    self.validationAlert("LogIn Error", message: "invalid email or password please try again")
                }
                })
            case .Signup:
                UserController.createUser(emailTextField.text!, password: passwordTextField.text!, bio: bioTextField.text!, url: urlTextField.text!, completion: { (success, user) -> Void in
                    if success, let _ = user {
                        self.dismissViewControllerAnimated(true, completion: nil)
                        
                    }else {
                        self.validationAlert("SignUp Error", message: "invalid information. please check again")
                    }
                })
            case.Edit:
                UserController.updateUser(user!, userName: self.userNameTextField.text!, bio: self.bioTextField.text, url: self.urlTextField.text, completion: { (success, user) -> Void in
                    if success, let _ = user {
                        self.dismissViewControllerAnimated(true, completion: nil)
                        
                    }else {
                        self.validationAlert("Edit Error", message: "could not edit")
                    }
                })
                          /*
                // MARK: - Navigation
                
                // In a storyboard-based application, you will often want to do a little preparation before navigation
                override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
                // Get the new view controller using segue.destinationViewController.
                // Pass the selected object to the new view controller.
                }
                */

                
                
                // make an alert function to use throughout the entire code
            }
        }
    }
    
            func validationAlert(title: String, message: String) {
                let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert)
                // add action to alert
                let okay = UIAlertAction(title: "ok", style: .Default, handler: nil)

                alert.addAction(okay)
                }
                
    
    func updateWithUser(user: User) {
        self.user = user
        mode = .Edit
    }
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
}

