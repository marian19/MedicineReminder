//
//  PatientContract.swift
//  MedicineReminder
//
//  Created by Marian on 6/24/17.
//  Copyright © 2017 Marian. All rights reserved.
//

import Foundation

protocol PatientMedicinesPresenterProtocol : class{
    
    func getMedicinesForPatient(email: String)
}

protocol PatientMedicinesViewProtocol : class{
    
    func successWith(medicines: [PatientMedicine])
    func showErrorMsg(msg: String)
    func showProgressBar()
    func hideProgressBar()
    
}
