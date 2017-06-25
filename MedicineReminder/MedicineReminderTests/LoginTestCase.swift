//
//  LoginTestCase.swift
//  MedicineReminder
//
//  Created by Marian on 6/25/17.
//  Copyright © 2017 Marian. All rights reserved.
//

import XCTest
@testable import MedicineReminder
import TextFieldEffects

class LoginTestCase: XCTestCase {
    
    var viewController: LoginViewController!
    
    
    override func setUp() {
        super.setUp()
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
         viewController = storyboard.instantiateInitialViewController() as! LoginViewController
        UIApplication.shared.keyWindow!.rootViewController = viewController
    }
    
    override func tearDown() {
        super.tearDown()
        viewController = nil
    }
    
    func testIBOutlest() {
        XCTAssertNotNil((viewController.emailTextField ), "emailTextField not connected in storyboard")
        XCTAssertNotNil((viewController.passwordTextField), "passwordTextField not connected in storyboard")
        XCTAssertNotNil((viewController.scrollView), "scrollView not connected in storyboard")

    }
    
    func testProperties() {
        
        XCTAssertNotNil((viewController.presenter), "presenter not intialize")
        
    }
    
    func testSignIn() {
        viewController.viewDidLoad()
        let presenter = MockPresenter()
        viewController.presenter = presenter
    presenter.login(email: "", password: "")
        XCTAssertTrue(presenter.loginGotCalled , "login should have been called")
        
    }
    
    func testLogoutGotCalled() {
        let presenter = MockPresenter()
        viewController.presenter = presenter
        viewController.logout(segue: UIStoryboardSegue.init(identifier: "", source: viewController, destination: UIViewController.init()))
        XCTAssertTrue(presenter.logoutGotCalled , "logout should have been called")
    }
    
    
}

class MockPresenter: LoginPresenterProtocol {
    var loginGotCalled = false
    var logoutGotCalled = false
    
    func login(email: String, password: String) {
        loginGotCalled = true
    }
    func logout(){
        logoutGotCalled = true
    }
    
}
