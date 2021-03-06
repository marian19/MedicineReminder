//
//  Nurse+CoreDataClass.swift
//  MedicineReminder
//
//  Created by Marian on 6/23/17.
//  Copyright © 2017 Marian. All rights reserved.
//

import Foundation
import CoreData

@objc(Nurse)
public class Nurse: NSManagedObject {
    
    // get Nurse with email or with email and password
    public class func getNurseWith(email:String, password: String = "") -> Nurse? {
        
        let managedObjectContext = CoreDataManager.sharedInstance.managedObjectContext
        var nurse: Nurse?
        do {
            let fetchRequest : NSFetchRequest<Nurse> = Nurse.fetchRequest()
            
            if password.isBlank {
                fetchRequest.predicate = NSPredicate(format: "email LIKE[cd] %@", email)
            }else{
                fetchRequest.predicate = NSPredicate(format: "email LIKE[cd] %@ AND password == %@", email,password)
            }
            let fetchedResults = try managedObjectContext.fetch(fetchRequest)
            
            if fetchedResults.first != nil {
                nurse = fetchedResults.first
            }
        }
        catch {
            print ("fetch task failed", error)
        }
        return nurse
    }
    
    
    // add new Nurse "Sign up"

    public class func addNurseWith(email:String, password: String) -> (Nurse, Bool) {
        
        let managedObjectContext = CoreDataManager.sharedInstance.managedObjectContext
        var nurse = Nurse.getNurseWith(email: email)
        
        // "Email already exists"
        if (nurse != nil)  {
            return(nurse!,false)
        }else{
            //"Account has been added successfully"
            nurse = NSEntityDescription.insertNewObject(forEntityName: "Nurse", into: managedObjectContext) as? Nurse
            
            nurse?.email = email
            nurse?.password = password
            
            do {
                try managedObjectContext.save()
                return(nurse!,true)
                
            } catch {
                fatalError("Failure to save context: \(error)")
            }
        }
    }
    
}
