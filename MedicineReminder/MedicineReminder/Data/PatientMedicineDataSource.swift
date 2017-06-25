//
//  PatientMedicineDataSource.swift
//  MedicineReminder
//
//  Created by Marian on 6/25/17.
//  Copyright © 2017 Marian. All rights reserved.
//

import Foundation


struct PatientMedicineDataSource {
    
    func getMedicinesForPatient(email: String, completionHandler:@escaping ([PatientMedicine]?) -> Void){
        
        DispatchQueue.global(qos: .background).async {
            
            let medicines = PatientMedicine.getMedicinesForPatient(email: email)
            completionHandler(medicines)
        }
    }
}
