//
//  LoginViewController.swift
//  MedicineReminder
//
//  Created by Marian on 6/23/17.
//  Copyright © 2017 Marian. All rights reserved.
//

import UIKit
import TextFieldEffects
import MBProgressHUD

class LoginViewController: UIViewController {
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var passwordTextField: HoshiTextField!
    @IBOutlet weak var emailTextField: HoshiTextField!
    
    // MARK: - Class Properties
    
    var progressView : MBProgressHUD?
    var presenter : LoginPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        presenter = LoginPresenter(view: self)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let userDefaults = UserDefaults.standard
        
        let email = userDefaults.string(forKey: "email")
        if email != nil {
            self.scrollView.isHidden = true
        } else {
            self.scrollView.isHidden = false
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let userDefaults = UserDefaults.standard
        let email = userDefaults.string(forKey: "email")
        if email != nil {
            self.performSegue(withIdentifier: "successLogin", sender: self)
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func signIn(_ sender: Any) {
        presenter?.login(email: emailTextField.text!, password: passwordTextField.text!)
    }
    
    @IBAction func logout(segue:UIStoryboardSegue) {
        
        let userDefaults = UserDefaults.standard
        userDefaults.set( nil, forKey: "email")
    }
}

// MARK: - SignupViewProtocol

extension LoginViewController: LoginViewProtocol{
    
    func success(){
        self.performSegue(withIdentifier: "successLogin", sender: self)
        
    }
    
    func showErrorMsg(msg : String){
        alert(message: msg)
    }
    func showProgressBar(){
        progressView = self.showGlobalProgressHUDWithTitle(view: self.view, title: nil)
        
    }
    
    func hideProgressBar(){
        self.progressView!.hide(animated: false)
        
    }
}
