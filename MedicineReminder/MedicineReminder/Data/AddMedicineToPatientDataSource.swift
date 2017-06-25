//
//  AddMedicineToPatientDataSource.swift
//  MedicineReminder
//
//  Created by Marian on 6/25/17.
//  Copyright © 2017 Marian. All rights reserved.
//

import Foundation

struct AddMedicineToPatientDataSource {
    
    func addMedicine(medicine:Medicine, patient: Patient, time: Date , dosage: String, priority: String, uuid: String, completionHandler:@escaping (PatientMedicine, Bool) -> Void){
        DispatchQueue.global(qos: .background).async {
            
            let (patientMedicine, isSuccess) = PatientMedicine.addMedicine(medicine: medicine, patient: patient, time: time, dosage: dosage, priority: priority, uuid: uuid)
            
            completionHandler(patientMedicine,isSuccess)
        }
    }
}
