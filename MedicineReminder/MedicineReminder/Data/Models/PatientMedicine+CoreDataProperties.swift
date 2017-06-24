//
//  PatientMedicine+CoreDataProperties.swift
//  MedicineReminder
//
//  Created by Marian on 6/23/17.
//  Copyright © 2017 Marian. All rights reserved.
//

import Foundation
import CoreData


extension PatientMedicine {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PatientMedicine> {
        return NSFetchRequest<PatientMedicine>(entityName: "PatientMedicine")
    }

    @NSManaged public var name: String?
    @NSManaged public var time: NSDate?
    @NSManaged public var dosage: Double
    @NSManaged public var priority: Int16
    @NSManaged public var patient: Patient?

}
