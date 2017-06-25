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
    
    var progressView: MBProgressHUD?
    var presenter: LoginPresenterProtocol?
    var nurseEmail: String?
    
    // MARK: - Class methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        hideViewIfUserLoggedInBefore()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        goToHomeScreenIfUserLoggedInBefore()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func setupViewController()  {
        hideKeyboardWhenTappedAround()
        presenter = LoginPresenter(view: self)
        let userDefaults = UserDefaults.standard
        nurseEmail = userDefaults.string(forKey: "email")
        
    }
    
    private func hideViewIfUserLoggedInBefore(){
        if nurseEmail != nil {
            self.scrollView.isHidden = true
        } else {
            self.scrollView.isHidden = false
        }
    }
    
    private func goToHomeScreenIfUserLoggedInBefore(){
        
        if nurseEmail != nil {
            self.performSegue(withIdentifier: "successLogin", sender: self)
            
        }
    }
    
    // MARK: - @IBAction
    
    @IBAction func signIn(_ sender: Any) {
        presenter?.login(email: emailTextField.text!, password: passwordTextField.text!)
    }
    
    @IBAction func logout(segue:UIStoryboardSegue) {
        presenter?.logout()
    }
}

// MARK: - LoginViewProtocol implementation

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
        self.progressView = nil
        
    }
}
