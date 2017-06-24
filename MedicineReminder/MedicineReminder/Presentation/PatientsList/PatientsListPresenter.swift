//
//  PatientsListPresenter.swift
//  MedicineReminder
//
//  Created by Marian on 6/24/17.
//  Copyright © 2017 Marian. All rights reserved.
//

import Foundation

class PatientsListPresenter: PatientsListPresenterProtocol{
    
    weak var view: PatientsListViewProtocol?
    
    required init(view: PatientsListViewProtocol) {
        self.view = view
        
    }
    
    // MARK: - PatientsListPresenterProtocol
    func getPatientsListForCurrentNurse() {
        
        let userDefaults = UserDefaults.standard
        let email = userDefaults.string(forKey: "email")
        
        view?.showProgressBar()
        
        PatientListDataSource.init().getPatientsListForNurse(email: email!) { [weak self] patients in
            DispatchQueue.main.async {
                
                self?.view?.hideProgressBar()
                self?.view?.successWith(patients: patients!)
            }
        }
        
    }
    
    
}
