//
//  SignupPresenter.swift
//  MedicineReminder
//
//  Created by Marian on 6/23/17.
//  Copyright © 2017 Marian. All rights reserved.
//

import Foundation

class SignupPresenter: SignupPresenterProtocol{
    
    weak var view: SignupViewProtocol?
    
    required init(view: SignupViewProtocol) {
        self.view = view
    }
    
    // MARK: - SignupPresenterProtocol implementaion
    
    func signup(email: String, password: String) {
        
        // validate email
        
        if (email.isEmail) {
            
            // validate password
            
            if password.isValidPassword {
                
                view?.showProgressBar()
                
                SignUpDataSource.init().signup(email: email, password: password.sha1(), completionHandler: { [weak self] isSuccess in
                    
                    DispatchQueue.main.async {
                        
                        self?.view?.hideProgressBar()
                        if isSuccess {
                            self?.view?.success(msg: "Account has been added successfully")
                        }else{
                            
                            self?.view?.showErrorMsg(msg: "Email already exists")
                            
                        }
                    }
                })
                
            }else{
                view?.showErrorMsg(msg: "Invalid password")
                
            }
        }else{
            view?.showErrorMsg(msg: "Invalid email")
        }
        
    }
    
    
}
