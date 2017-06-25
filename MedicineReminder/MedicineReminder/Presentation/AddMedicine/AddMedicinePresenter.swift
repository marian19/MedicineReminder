//
//  AddMedicinePresenter.swift
//  MedicineReminder
//
//  Created by Marian on 6/25/17.
//  Copyright © 2017 Marian. All rights reserved.
//

import Foundation

class AddMedicinePresenter: AddMedicinePresenterProtocol{
    
    weak var view: AddMedicineViewProtocol?
    
    required init(view: AddMedicineViewProtocol) {
        self.view = view
    }
    
    // MARK: - AddMedicinePresenterProtocol implementation
    func addMedicine(medicine:Medicine?, patient: Patient, time: Date? , dosage: String?, priority: String?){
        
        if medicine != nil {
            if time != nil {
                if dosage != nil {
                    if !(priority?.isBlank)! {
                        
                        view?.showProgressBar()
                        let uuid = UUID().uuidString
                        
                        AddMedicineToPatientDataSource.init().addMedicine(medicine: medicine!, patient: patient, time: time!, dosage: dosage!, priority: priority!, uuid: uuid, completionHandler: { [weak self] patientMedicine, isSuccess in
                            DispatchQueue.main.async {
                                
                                self?.view?.hideProgressBar()
                                if isSuccess {
                                    self?.view?.successWith(msg: "Medicine has been added successfully")
                                    
                                    //add new local notification
                                    NotificationsManager.sharedInstance.newNotification(date: patientMedicine.time! as Date, uuid: patientMedicine.uuid!, body: "It's time for \(patientMedicine.patient!.name!) to get \(patientMedicine.medicine!.name!)")
                                    
                                }else{
                                    self?.view?.showErrorMsg(msg: "Something")
                                }
                            }
                        })
                    }else{
                        self.view?.showErrorMsg(msg: "You have to add priority")
                    }
                }else{
                    self.view?.showErrorMsg(msg: "You have to add dosage")
                }
            }else{
                self.view?.showErrorMsg(msg: "You have to add date")
            }
        }else{
            self.view?.showErrorMsg(msg: "You have to add medicine")
        }
    }
}
