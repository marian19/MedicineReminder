//
//  MedicinesListPresenter.swift
//  MedicineReminder
//
//  Created by Marian on 6/24/17.
//  Copyright © 2017 Marian. All rights reserved.
//

import Foundation

class MedicinesListPresenter: MedicinesListPresenterProtocol{
    
    weak var view: MedicinesListViewProtocol?
    
    required init(view: MedicinesListViewProtocol) {
        self.view = view
        
    }
    
    // MARK: - LoginPresenterProtocol
    func getMedicinesList() {
        
        view?.showProgressBar()
        
        MedicinesListDataSource.init().getMedicinesList(completionHandler: { [weak self] medicines in
            DispatchQueue.main.async {
                
                self?.view?.hideProgressBar()
                self?.view?.successWith(medicines: medicines!)
            }
            
        })
    }
    
    func addNewMedicine(name:String){
        view?.showProgressBar()
        
        NewMedicineDataSource.init().addMedicineWith(name: name,completionHandler: { [weak self] medicine,isSuccess in
            DispatchQueue.main.async {
                
                self?.view?.hideProgressBar()
                if isSuccess {
                    self?.view?.successWith(medicine: medicine, msg: "Medicine has been added successfully")
                }else{
                    
                    self?.view?.showErrorMsg(msg: "Medicine already exists")
                    
                }            }
            
        })
        
    }
    
    
}
