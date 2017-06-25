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
    
    
    // schedule medicine to patient
    public class func addMedicine(medicine:Medicine, patient: Patient, time: Date , dosage: String, priority: String,uuid: String) -> (PatientMedicine, Bool) {
        
        let managedObjectContext = CoreDataManager.sharedInstance.managedObjectContext
        
        let patientMedicine = NSEntityDescription.insertNewObject(forEntityName: "PatientMedicine", into: managedObjectContext) as? PatientMedicine
        patientMedicine?.uuid = uuid
        patientMedicine?.medicine = medicine
        patientMedicine?.patient = patient
        patientMedicine?.time = time as NSDate
        patientMedicine?.dosage = dosage
        patientMedicine?.priority = priority
        
        
        do {
            try managedObjectContext.save()
            return(patientMedicine!,true)
            
        } catch {
            fatalError("Failure to save context: \(error)")
        }
    }
    
    // get scheduled medicines for certain patient
    public class func getMedicinesForPatient(email:String) -> [PatientMedicine]? {
        
        let managedObjectContext = CoreDataManager.sharedInstance.managedObjectContext
        var medicines = [PatientMedicine]()
        
        do {
            let fetchRequest : NSFetchRequest<PatientMedicine> = PatientMedicine.fetchRequest()
            
            fetchRequest.predicate = NSPredicate(format: "patient.email LIKE[cd] %@", email)
            
            let fetchedResults = try managedObjectContext.fetch(fetchRequest)
            medicines = fetchedResults
        }
        catch {
            print ("fetch task failed", error)
        }
        return medicines
    }
    
    // get scheduled medicines for certain Nurse
    public class func getMedicinesForNurse(email:String) -> [PatientMedicine]? {
        
        let managedObjectContext = CoreDataManager.sharedInstance.managedObjectContext
        var medicines = [PatientMedicine]()
        
        do {
            let fetchRequest : NSFetchRequest<PatientMedicine> = PatientMedicine.fetchRequest()
            
            fetchRequest.predicate = NSPredicate(format: "patient.nurse.email LIKE[cd] %@", email)
            
            let fetchedResults = try managedObjectContext.fetch(fetchRequest)
            medicines = fetchedResults
            
        }
        catch {
            print ("fetch task failed", error)
        }
        return medicines
    }
}

