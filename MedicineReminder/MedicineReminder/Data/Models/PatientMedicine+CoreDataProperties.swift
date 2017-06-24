//
//  PatientMedicine+CoreDataProperties.swift
//  
//
//  Created by Marian on 6/24/17.
//
//

import Foundation
import CoreData


extension PatientMedicine {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PatientMedicine> {
        return NSFetchRequest<PatientMedicine>(entityName: "PatientMedicine")
    }

    @NSManaged public var dosage: Double
    @NSManaged public var priority: Int16
    @NSManaged public var time: NSDate?
    @NSManaged public var patient: Patient?
    @NSManaged public var medicine: Medicine?

}
