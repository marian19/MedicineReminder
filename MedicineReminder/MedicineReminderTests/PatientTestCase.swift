//
//  PatientTextCase.swift
//  MedicineReminder
//
//  Created by Marian on 6/25/17.
//  Copyright © 2017 Marian. All rights reserved.
//

import XCTest
import CoreData

@testable import MedicineReminder

class PatientTestCase: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testThatWeCanCreatePatient() {
        let managedObjectContext = CoreDataManager.sharedInstance.managedObjectContext
        
        let entity = NSEntityDescription.entity(forEntityName: "Patient", in: managedObjectContext)
        let patient = Patient(entity: entity!, insertInto: managedObjectContext)
        XCTAssertNotNil(patient, "unable to create a patient")
        
    }
    
    func testThatWeCanGetPatientWithEmail() {
        let email = "patient1@hospital.com"
        var patient: Patient?
        let managedObjectContext = CoreDataManager.sharedInstance.managedObjectContext
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
        XCTAssertNotNil(patient, "unable to get patient")
    }
    
    func testThatWeCanGetPatientsForNurse() {
        let email = "nurse@hospital.com"
        var patients: [Patient]?
        
        let managedObjectContext = CoreDataManager.sharedInstance.managedObjectContext
        do {
            let fetchRequest : NSFetchRequest<Patient> = Patient.fetchRequest()
            
            fetchRequest.predicate = NSPredicate(format: "email LIKE[cd] %@", email)
            
            let fetchedResults = try managedObjectContext.fetch(fetchRequest)
            
            patients = fetchedResults
            
        }
        catch {
            print ("fetch task failed", error)
        }
        XCTAssertNotNil(patients, "unable to get patients")
    }
}
