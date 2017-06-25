//
//  LoginContract.swift
//  MedicineReminder
//
//  Created by Marian on 6/23/17.
//  Copyright © 2017 Marian. All rights reserved.
//

import Foundation

protocol LoginPresenterProtocol : class{
    
    func login(email: String, password: String)
    func logout()
}

protocol LoginViewProtocol : class{
    
    func success()
    func showErrorMsg(msg : String)
    func showProgressBar()
    func hideProgressBar()
    
}
