//
//  CoreDataTestCase.swift
//  MedicineReminder
//
//  Created by Marian on 6/25/17.
//  Copyright © 2017 Marian. All rights reserved.
//

import XCTest
@testable import MedicineReminder

class CoreDataManagerTestCase: XCTestCase {
    
    var coreDataManger: CoreDataManager!
    
    override func setUp() {
        super.setUp()
        coreDataManger = CoreDataManager.sharedInstance
        
    }
    
    override func tearDown() {
        self.coreDataManger = nil
        super.tearDown()
    }
    
    func testCoreDataManagerIsNotNil() {
        XCTAssertNotNil(self.coreDataManger, "unable to create CoreDataManager")
    }
 
    func testCoreDataManagerCreateManagedObjectContext() {
        XCTAssertNotNil(self.coreDataManger.managedObjectContext, "unable to create managedObjectContext")
    }
    
}
