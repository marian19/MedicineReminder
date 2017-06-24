//
//  NewMedicineDataSource.swift
//  MedicineReminder
//
//  Created by Marian on 6/24/17.
//  Copyright © 2017 Marian. All rights reserved.
//

import Foundation

struct NewMedicineDataSource {
    
    func addMedicineWith(name: String, completionHandler:@escaping (Medicine,Bool) -> Void){
        
        DispatchQueue.global(qos: .background).async {
            
            let (medicine, isSuccess) = Medicine.addMedicineWith(name: name)
            completionHandler(medicine, isSuccess)
        }
    }
}
