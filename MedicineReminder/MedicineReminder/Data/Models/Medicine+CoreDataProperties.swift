//
//  Medicine+CoreDataProperties.swift
//  
//
//  Created by Marian on 6/24/17.
//
//

import Foundation
import CoreData


extension Medicine {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Medicine> {
        return NSFetchRequest<Medicine>(entityName: "Medicine")
    }

    @NSManaged public var name: String?

}
