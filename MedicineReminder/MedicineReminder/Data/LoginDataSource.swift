//
//  LoginDataSource.swift
//  MedicineReminder
//
//  Created by Marian on 6/24/17.
//  Copyright © 2017 Marian. All rights reserved.
//

import Foundation
struct LoginDataSource {

    func login(email: String, password: String, completionHandler:@escaping (Nurse?) -> Void){
        DispatchQueue.global(qos: .background).async {

        let nurse = Nurse.getNurseWith(email: email, password: password)
        completionHandler(nurse)
        }
    }
}
