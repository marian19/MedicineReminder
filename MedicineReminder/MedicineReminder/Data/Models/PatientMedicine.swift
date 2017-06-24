//
//  PatientMedicine+CoreDataClass.swift
//  MedicineReminder
//
//  Created by Marian on 6/23/17.
//  Copyright © 2017 Marian. All rights reserved.
//

import Foundation
import CoreData

@objc(PatientMedicine)
public class PatientMedicine: NSManagedObject {
    
//    public class func getAllMedicinesName() -> [String]? {
//        
//        var medicines = [String]()
//        
//        let managedObjectContext = CoreDataManager.sharedInstance.managedObjectContext
//        do {
//            let fetchRequest : NSFetchRequest<PatientMedicine> = PatientMedicine.fetchRequest()
//            
//            fetchRequest.propertiesToFetch = ["name"]
//            fetchRequest.returnsDistinctResults = true
//            fetchRequest.resultType = NSFetchRequestResultType.dictionaryResultType
//            
//            do {
//                let results = try managedObjectContext.fetch(fetchRequest)
//                
//                // 2) cast the results to the expected dictionary type:
//                let resultsDict = results as! [[String: String]]
//                
//                for medicine in resultsDict {
//                    medicines.append(medicine["name"]!)
//                }
//                
//            } catch let err as NSError {
//                print(err.debugDescription)
//            }
//            return medicines
//        }
//    }
}
