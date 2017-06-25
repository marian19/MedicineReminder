//
//  AddPatientPresenter.swift
//  MedicineReminder
//
//  Created by Marian on 6/24/17.
//  Copyright © 2017 Marian. All rights reserved.
//

import Foundation

class AddPatientPresenter: AddPatientPresenterProtocol{
    
    weak var view: AddPatientViewProtocol?
    
    required init(view: AddPatientViewProtocol) {
        self.view = view
        
    }
    
    // MARK: - AddPatientPresenterProtocol implementation
    
    func addPatientToCurrentNurseWith(email:String, name: String, phone: String){
        
        if (email.isEmail) {
            
            if (name.characters.count < 128 && !(name.isBlank)) {
                
                if phone.isPhoneNumber {
                    
                    let userDefaults = UserDefaults.standard
                    let nurseEmail = userDefaults.string(forKey: "email")
                    
                    view?.showProgressBar()
                    
                    AddPatientDataSource.init().addPatientToCurrentNurseWith(email: email, name: name, phone: phone, nurseEmail: nurseEmail!, completionHandler: { [weak self] isSuccess in
                        
                        DispatchQueue.main.async {
                            
                            self?.view?.hideProgressBar()
                            if isSuccess {
                                self?.view?.successWith(msg: "Patient has been added successfully")
                            }else{
                                self?.view?.showErrorMsg(msg: "Patient already exists and is associated to another nurse")
                            }
                        }
                    })
                    
                }else{
                    view?.showErrorMsg(msg: "Invalid phone number")
                    
                }
            }else{
                view?.showErrorMsg(msg: "Invalid name")
                
            }
        }else{
            view?.showErrorMsg(msg: "Invalid email")
            
        }
    }
}
