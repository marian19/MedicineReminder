//
//  MedicinesListDataSource.swift
//  MedicineReminder
//
//  Created by Marian on 6/24/17.
//  Copyright © 2017 Marian. All rights reserved.
//

import Foundation

struct MedicinesListDataSource {
    
    func getMedicinesList(completionHandler:@escaping ([Medicine]?) -> Void){
        
        DispatchQueue.global(qos: .background).async {

        let medicines = Medicine.getAllMedicines()
        completionHandler(medicines)
        }
    }
}
