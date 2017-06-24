//
//  AddPatientContract.swift
//  MedicineReminder
//
//  Created by Marian on 6/24/17.
//  Copyright © 2017 Marian. All rights reserved.
//

import Foundation

protocol AddPatientPresenterProtocol : class{
    
    func addPatientToCurrentNurseWith(email:String, name: String, phone: String)
}

protocol AddPatientViewProtocol : class{
    
    func successWith(msg: String)
    func showErrorMsg(msg: String)
    func showProgressBar()
    func hideProgressBar()
    
}
