//
//  AddMedicineContract.swift
//  MedicineReminder
//
//  Created by Marian on 6/25/17.
//  Copyright © 2017 Marian. All rights reserved.
//

import Foundation

protocol AddMedicinePresenterProtocol : class{
    
    func addMedicine(medicine:Medicine?, patient: Patient, time: Date? , dosage: String?, priority: String?)
}

protocol AddMedicineViewProtocol : class{
    
    func successWith(msg: String)
    func showErrorMsg(msg: String)
    func showProgressBar()
    func hideProgressBar()
    
}
