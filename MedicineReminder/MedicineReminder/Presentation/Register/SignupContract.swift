//
//  SignupContract.swift
//  MedicineReminder
//
//  Created by Marian on 6/23/17.
//  Copyright © 2017 Marian. All rights reserved.
//

import Foundation

protocol SignupPresenterProtocol : class{
    
    func signup(email: String, password: String)
}

protocol SignupViewProtocol : class{
    
    func success(msg : String)
    func showErrorMsg(msg : String)
    func showProgressBar()
    func hideProgressBar()
    
}
