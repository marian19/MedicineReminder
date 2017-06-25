//
//  Nurse.swift
//  MedicineReminder
//
//  Created by Marian on 6/25/17.
//  Copyright © 2017 Marian. All rights reserved.
//

import XCTest
import CoreData

@testable import MedicineReminder

class NurseTestCase: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testThatWeCanCreateNurse() {
        let managedObjectContext = CoreDataManager.sharedInstance.managedObjectContext
        
        let entity = NSEntityDescription.entity(forEntityName: "Nurse", in: managedObjectContext)
        let nurse = Nurse(entity: entity!, insertInto: managedObjectContext)
        XCTAssertNotNil(nurse, "unable to create a nurse")

    }
    
    func testThatWeCanGetNurseWithEmail() {
        let email = "nurse@hospital.com"
        var nurse: Nurse?
        let managedObjectContext = CoreDataManager.sharedInstance.managedObjectContext
        do {
            let fetchRequest : NSFetchRequest<Nurse> = Nurse.fetchRequest()
            
                fetchRequest.predicate = NSPredicate(format: "email LIKE[cd] %@", email)
            
            let fetchedResults = try managedObjectContext.fetch(fetchRequest)
            
            if fetchedResults.first != nil {
                nurse = fetchedResults.first
            }
        }
        catch {
            print ("fetch task failed", error)
        }
        XCTAssertNotNil(nurse, "unable to get  nurse")
    }
}
