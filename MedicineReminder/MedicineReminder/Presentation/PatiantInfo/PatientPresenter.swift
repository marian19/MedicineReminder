//
//  PatientPresenter.swift
//  MedicineReminder
//
//  Created by Marian on 6/24/17.
//  Copyright © 2017 Marian. All rights reserved.
//

import Foundation

class PatientPresenter: PatientMedicinesPresenterProtocol{
    
    weak var view: PatientMedicinesViewProtocol?
    
    required init(view: PatientMedicinesViewProtocol) {
        self.view = view
        
    }
    
    // MARK: - PatientMedicinesPresenterProtocol implementation
    func getMedicinesForPatient(email: String){
    
        view?.showProgressBar()
        PatientMedicineDataSource.init().getMedicinesForPatient(email: email, completionHandler: { [weak self] medicines in
            DispatchQueue.main.async {
                
                self?.view?.hideProgressBar()
                self?.view?.successWith(medicines: medicines!)
            }
            
        })
        
    }
    
}
