//
//  Medicine+CoreDataClass.swift
//  MedicineReminder
//
//  Created by Marian on 6/23/17.
//  Copyright © 2017 Marian. All rights reserved.
//

import Foundation
import CoreData

@objc(Medicine)
public class Medicine: NSManagedObject {
    
    //  get all medicines list
    public class func getAllMedicines() -> [Medicine]? {
        
        var medicines = [Medicine]()
        let managedObjectContext = CoreDataManager.sharedInstance.managedObjectContext
        do {
            let fetchRequest : NSFetchRequest<Medicine> = Medicine.fetchRequest()
            
            let fetchedResults = try managedObjectContext.fetch(fetchRequest)
            
            medicines = fetchedResults
        }
        catch {
            print ("fetch task failed", error)
        }
        return medicines
    }
    
    // get medicine object with name
    public class func getMedicineWith(name:String) -> Medicine? {
        
        let managedObjectContext = CoreDataManager.sharedInstance.managedObjectContext
        var medicine: Medicine?
        do {
            let fetchRequest : NSFetchRequest<Medicine> = Medicine.fetchRequest()
            
            fetchRequest.predicate = NSPredicate(format: "name LIKE[cd] %@", name)
            
            
            let fetchedResults = try managedObjectContext.fetch(fetchRequest)
            if fetchedResults.first != nil {
                medicine = fetchedResults.first
            }
        }
        catch {
            print ("fetch task failed", error)
        }
        return medicine
    }
    
    // add new medicine
    public class func addMedicineWith(name:String) -> (Medicine ,Bool) {
        
        let managedObjectContext = CoreDataManager.sharedInstance.managedObjectContext
        var medicine = Medicine.getMedicineWith(name: name)
        
        // "already exists"
        if (medicine != nil)  {
            return(medicine!,false)
        }else{
            //" has been added successfully"
            medicine = NSEntityDescription.insertNewObject(forEntityName: "Medicine", into: managedObjectContext) as? Medicine
            
            medicine?.name = name
            
            do {
                try managedObjectContext.save()
                return(medicine!,true)
                
            } catch {
                fatalError("Failure to save context: \(error)")
            }
        }
    }
    
    
}
