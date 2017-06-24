//
//  MedicinesListContract.swift
//  MedicineReminder
//
//  Created by Marian on 6/24/17.
//  Copyright © 2017 Marian. All rights reserved.
//

import Foundation

protocol PatientsListPresenterProtocol : class{
    
    func getPatientsListForCurrentNurse()
}

protocol PatientsListViewProtocol : class{

    func successWith(patients: [Patient])
    func showErrorMsg(msg: String)
    func showProgressBar()
    func hideProgressBar()
    
}
