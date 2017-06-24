//
//  AddPatientDataSource.swift
//  MedicineReminder
//
//  Created by Marian on 6/24/17.
//  Copyright © 2017 Marian. All rights reserved.
//

import Foundation

struct AddPatientDataSource {

func addPatientToCurrentNurseWith(email:String, name: String, phone: String, nurseEmail: String, completionHandler:@escaping (Bool) -> Void){
    DispatchQueue.global(qos: .background).async {
        
        let (_, isSuccess) = Patient.addPatientWith(email: email, name: name, phone: phone, nurseEmail: nurseEmail)
        
        completionHandler(isSuccess)
    }
}
}
