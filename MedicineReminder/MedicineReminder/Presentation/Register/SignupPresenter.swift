//
//  SignupPresenter.swift
//  MedicineReminder
//
//  Created by Marian on 6/23/17.
//  Copyright © 2017 Marian. All rights reserved.
//

import Foundation

class SignupPresenter: SignupPresenterProtocol{
    
    
    
    weak var signupView: SignupViewProtocol?
    
    required init(view: SignupViewProtocol) {
        self.signupView = view
        
    }
    
    // MARK: - SignupPresenterProtocol
    
    func Signup(email: String, password: String) {
        if (email.isEmail) {
            
            if password.isValidPassword {
                signupView?.showProgressBar()
                let (_, isSuccess) = Nurse.addNurseWith(email: email, password: password.sha1())
                signupView?.hideProgressBar()
                if isSuccess {
                    signupView?.success(msg: "Account has been added successfully")
                }else{
                    
                    signupView?.showErrorMsg(msg: "Email already exists")
                    
                }
            }else{
                signupView?.showErrorMsg(msg: "Invalid password")
                
            }
        }else{
            signupView?.showErrorMsg(msg: "Invalid email")
        }
        
    }
    
    
}
