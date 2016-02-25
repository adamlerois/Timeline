//
//  LoginSignupViewController.swift
//  Timeline
//
//  Created by youcef bouhafna on 2/23/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import UIKit

class LoginSignupViewController: UIViewController {
    
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var bioTextField: UITextField!
    @IBOutlet weak var urlTextField: UITextField!
    @IBOutlet weak var actionButton: UIButton!
    
    // computed property
    var fieldsAreValid: Bool {
        get {
            switch mode {
            case .Login:
               return  !(emailTextField.text!.isEmpty  || passwordTextField.text!.isEmpty)
            case .Signup:
                return !(emailTextField.text!.isEmpty || passwordTextField.text!.isEmpty || userNameTextField.text!.isEmpty)
                
                
                }
        
                }
            
                }
                
                
                
    @IBAction func actionButtonTapped(sender: AnyObject) {
        
    }
    
        
    
    
    
    
    
    enum ViewMode {
        case Login
        case Signup
    }
    var mode: ViewMode = .Signup

    
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
            }
            
        }

        
    

    @IBAction func actionButton(sender: AnyObject) {
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
