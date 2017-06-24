//
//  MedicinesListContract.swift
//  MedicineReminder
//
//  Created by Marian on 6/24/17.
//  Copyright © 2017 Marian. All rights reserved.
//

import Foundation

protocol MedicinesListPresenterProtocol : class{
    
    func getMedicinesList()
    func addNewMedicine(name:String)
}

protocol MedicinesListViewProtocol : class{

    func successWith(medicines: [Medicine])
    func successWith(medicine: Medicine,msg: String)
    func showErrorMsg(msg: String)
    func showProgressBar()
    func hideProgressBar()
    
}
