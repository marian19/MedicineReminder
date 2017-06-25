//
//  SignupViewController.swift
//  MedicineReminder
//
//  Created by Marian on 6/23/17.
//  Copyright © 2017 Marian. All rights reserved.
//

import UIKit
import TextFieldEffects
import MBProgressHUD

class SignupViewController: UIViewController {
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var passwordTextField: HoshiTextField!
    @IBOutlet weak var emailTextField: HoshiTextField!
    
    // MARK: - Class Properties
    
    var progressView : MBProgressHUD?
    var presenter : SignupPresenterProtocol?
    
    
    // MARK: - Class methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewController()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func setupViewController()  {
        hideKeyboardWhenTappedAround()
        presenter = SignupPresenter(view: self)
    }
    
    
    // MARK: - @IBAction
    
    @IBAction func cancelSignUp(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
    
    @IBAction func signUp(_ sender: Any) {
        presenter?.signup(email: emailTextField.text!, password: passwordTextField.text!)
    }
}


// MARK: -  SignupViewProtocol implementation

extension SignupViewController: SignupViewProtocol{
    
    func success(msg : String){
        
        let alertController = UIAlertController(title: nil, message: msg, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default) {
            action in
            self.dismiss(animated: false, completion: nil)
            
        }
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
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
