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
    
    //get patient list for certain nurse
    public class func getAllPatientsForNurse(email: String) -> [Patient]? {
        
        var patients = [Patient]()
        let managedObjectContext = CoreDataManager.sharedInstance.managedObjectContext
        do {
            let fetchRequest : NSFetchRequest<Patient> = Patient.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "nurse.email LIKE[cd] %@", email)
            
            let fetchedResults = try managedObjectContext.fetch(fetchRequest)
            
            patients = fetchedResults
        }
        catch {
            print ("fetch task failed", error)
        }
        return patients
    }
    
    // get certain patient with email
    public class func getPatientWith(email:String) -> Patient? {
        
        let managedObjectContext = CoreDataManager.sharedInstance.managedObjectContext
        var patient: Patient?
        do {
            let fetchRequest : NSFetchRequest<Patient> = Patient.fetchRequest()
            
            fetchRequest.predicate = NSPredicate(format: "email LIKE[cd] %@", email)
            
            let fetchedResults = try managedObjectContext.fetch(fetchRequest)
            if fetchedResults.first != nil {
                patient = fetchedResults.first
            }
        }
        catch {
            print ("fetch task failed", error)
        }
        return patient
    }
    
    
    // add new patient to nurse
    public class func addPatientWith(email:String, name: String, phone: String , nurseEmail: String) -> (Patient, Bool) {
        
        let managedObjectContext = CoreDataManager.sharedInstance.managedObjectContext
        
        var patient = Patient.getPatientWith(email: email)
        // "Email already exists"
        if (patient != nil)  {
            return(patient!,false)
        }else{
            //"Account has been added successfully"
            patient = NSEntityDescription.insertNewObject(forEntityName: "Patient", into: managedObjectContext) as? Patient
            let nurse = Nurse.getNurseWith(email: nurseEmail)
            patient?.email = email
            patient?.name = name
            patient?.phone = phone
            patient?.nurse = nurse
            
            do {
                try managedObjectContext.save()
                return(patient!,true)
                
            } catch {
                fatalError("Failure to save context: \(error)")
            }
        }
    }
    
}
