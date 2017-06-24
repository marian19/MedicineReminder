//
//  Patient+CoreDataClass.swift
//  MedicineReminder
//
//  Created by Marian on 6/23/17.
//  Copyright © 2017 Marian. All rights reserved.
//

import Foundation
import CoreData

@objc(Patient)
public class Patient: NSManagedObject {

    public class func getAllPatients() -> [Patient]? {
        
        var patients = [Patient]()
        let managedObjectContext = CoreDataManager.sharedInstance.managedObjectContext
        do {
            let fetchRequest : NSFetchRequest<Patient> = Patient.fetchRequest()
            
            let fetchedResults = try managedObjectContext.fetch(fetchRequest)
            
            patients = fetchedResults
        }
        catch {
            print ("fetch task failed", error)
        }
        return patients
    }
    
}
