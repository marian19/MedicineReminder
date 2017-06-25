//
//  LoginPresenter.swift
//  MedicineReminder
//
//  Created by Marian on 6/23/17.
//  Copyright © 2017 Marian. All rights reserved.
//

import Foundation

class LoginPresenter: LoginPresenterProtocol{
    
    weak var view: LoginViewProtocol?
    
    required init(view: LoginViewProtocol) {
        self.view = view
        
    }
    
    // MARK: - LoginPresenterProtocol implementation
    
    func login(email: String, password: String) {
        
        if (email.isEmail) {
            
            if password.isValidPassword {
                
                view?.showProgressBar()
                
                LoginDataSource.init().login(email: email, password: password.sha1(), completionHandler: { [weak self] nurse in
                    DispatchQueue.main.async {
                        
                        self?.view?.hideProgressBar()
                        
                        if nurse == nil {
                            self?.view?.showErrorMsg(msg: "Incorrect user name or password")
                            
                        }else{
                            // save logged in email
                            let userDefaults = UserDefaults.standard
                            userDefaults.set( email, forKey: "email")
                            
                            // reschedule all notification for this nurse
                            NotificationsManager.sharedInstance.rescheduleAllNotifications()
                            
                            self?.view?.success()
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
    
    
    func logout(){
        NotificationsManager.sharedInstance.unscheduleAllNotifications();
        let userDefaults = UserDefaults.standard
        userDefaults.set( nil, forKey: "email")
    }
}



