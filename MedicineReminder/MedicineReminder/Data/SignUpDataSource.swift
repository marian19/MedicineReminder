//
//  SignUpDataSource.swift
//  MedicineReminder
//
//  Created by Marian on 6/24/17.
//  Copyright © 2017 Marian. All rights reserved.
//

import Foundation
struct SignUpDataSource {
    
    func Signup(email: String, password: String, completionHandler:@escaping (Bool) -> Void){
        DispatchQueue.global(qos: .background).async {

        let (_, isSuccess) = Nurse.addNurseWith(email: email, password: password)
        completionHandler(isSuccess)
        }
    }
}
