//
//  Patient+CoreDataProperties.swift
//  
//
//  Created by Marian on 6/25/17.
//
//

import Foundation
import CoreData


extension Patient {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Patient> {
        return NSFetchRequest<Patient>(entityName: "Patient")
    }

    @NSManaged public var email: String?
    @NSManaged public var name: String?
    @NSManaged public var phone: String?
    @NSManaged public var medicines: NSSet?
    @NSManaged public var nurse: Nurse?

}

// MARK: Generated accessors for medicines
extension Patient {

    @objc(addMedicinesObject:)
    @NSManaged public func addToMedicines(_ value: PatientMedicine)

    @objc(removeMedicinesObject:)
    @NSManaged public func removeFromMedicines(_ value: PatientMedicine)

    @objc(addMedicines:)
    @NSManaged public func addToMedicines(_ values: NSSet)

    @objc(removeMedicines:)
    @NSManaged public func removeFromMedicines(_ values: NSSet)

}
