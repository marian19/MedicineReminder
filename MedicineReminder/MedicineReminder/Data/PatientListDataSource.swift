//
//  PatientListDataSource.swift
//  MedicineReminder
//
//  Created by Marian on 6/24/17.
//  Copyright © 2017 Marian. All rights reserved.
//

import Foundation

struct PatientListDataSource {
    
    func getPatientsListForNurse(email: String, completionHandler:@escaping ([Patient]?) -> Void){
        
        DispatchQueue.global(qos: .background).async {
            
            let patients = Patient.getAllPatientsForNurse(email: email)
            completionHandler(patients)
        }
    }
}
