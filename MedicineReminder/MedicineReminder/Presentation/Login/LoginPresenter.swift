//
//  LoginPresenter.swift
//  MedicineReminder
//
//  Created by Marian on 6/23/17.
//  Copyright © 2017 Marian. All rights reserved.
//

import Foundation

class LoginPresenter: LoginPresenterProtocol{
    
    weak var loginView: LoginViewProtocol?
    
    required init(view: LoginViewProtocol) {
        self.loginView = view
        
    }
    
    // MARK: - LoginPresenterProtocol
    func login(email: String, password: String) {
        
        if (email.isEmail) {
        
            if password.isValidPassword {
                
                loginView?.showProgressBar()
                let nurse = Nurse.getNurseWith(email: email, password: password.sha1())
                loginView?.hideProgressBar()
                if nurse == nil {
                    loginView?.showErrorMsg(msg: "Incorrect user name or password")
                    
                }else{
                    loginView?.success()
                }
                
            }else{
                loginView?.showErrorMsg(msg: "Invalid password")
                
            }
        }else{
            loginView?.showErrorMsg(msg: "Invalid email")
        }
        
    }
    
    
}



