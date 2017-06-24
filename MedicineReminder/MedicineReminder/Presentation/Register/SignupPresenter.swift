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
    
    func signup(email: String, password: String) {
        if (email.isEmail) {
            
            if password.isValidPassword {
                signupView?.showProgressBar()
                
                SignUpDataSource.init().signup(email: email, password: password.sha1(), completionHandler: { [weak self] isSuccess in
                    DispatchQueue.main.async {
                        
                        self?.signupView?.hideProgressBar()
                        if isSuccess {
                            self?.signupView?.success(msg: "Account has been added successfully")
                        }else{
                            
                            self?.signupView?.showErrorMsg(msg: "Email already exists")
                            
                        }
                    }
                })
                
            }else{
                signupView?.showErrorMsg(msg: "Invalid password")
                
            }
        }else{
            signupView?.showErrorMsg(msg: "Invalid email")
        }
        
    }
    
    
}
