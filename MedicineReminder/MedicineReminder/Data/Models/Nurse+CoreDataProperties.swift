//
//  Nurse+CoreDataProperties.swift
//  
//
//  Created by Marian on 6/25/17.
//
//

import Foundation
import CoreData


extension Nurse {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Nurse> {
        return NSFetchRequest<Nurse>(entityName: "Nurse")
    }

    @NSManaged public var email: String?
    @NSManaged public var password: String?
    @NSManaged public var patients: NSSet?

}

// MARK: Generated accessors for patients
extension Nurse {

    @objc(addPatientsObject:)
    @NSManaged public func addToPatients(_ value: Patient)

    @objc(removePatientsObject:)
    @NSManaged public func removeFromPatients(_ value: Patient)

    @objc(addPatients:)
    @NSManaged public func addToPatients(_ values: NSSet)

    @objc(removePatients:)
    @NSManaged public func removeFromPatients(_ values: NSSet)

}
