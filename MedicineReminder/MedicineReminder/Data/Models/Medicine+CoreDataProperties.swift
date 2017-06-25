//
//  Medicine+CoreDataProperties.swift
//  
//
//  Created by Marian on 6/25/17.
//
//

import Foundation
import CoreData


extension Medicine {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Medicine> {
        return NSFetchRequest<Medicine>(entityName: "Medicine")
    }

    @NSManaged public var name: String?
    @NSManaged public var dosage: NSSet?

}

// MARK: Generated accessors for dosage
extension Medicine {

    @objc(addDosageObject:)
    @NSManaged public func addToDosage(_ value: PatientMedicine)

    @objc(removeDosageObject:)
    @NSManaged public func removeFromDosage(_ value: PatientMedicine)

    @objc(addDosage:)
    @NSManaged public func addToDosage(_ values: NSSet)

    @objc(removeDosage:)
    @NSManaged public func removeFromDosage(_ values: NSSet)

}
