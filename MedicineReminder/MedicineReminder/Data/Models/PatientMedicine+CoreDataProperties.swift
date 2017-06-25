//
//  PatientMedicine+CoreDataProperties.swift
//  
//
//  Created by Marian on 6/25/17.
//
//

import Foundation
import CoreData


extension PatientMedicine {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PatientMedicine> {
        return NSFetchRequest<PatientMedicine>(entityName: "PatientMedicine")
    }

    @NSManaged public var dosage: String?
    @NSManaged public var priority: String?
    @NSManaged public var time: NSDate?
    @NSManaged public var uuid: String?
    @NSManaged public var medicine: Medicine?
    @NSManaged public var patient: Patient?

}
