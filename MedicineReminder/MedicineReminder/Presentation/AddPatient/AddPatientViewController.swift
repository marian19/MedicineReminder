//
//  AddPatientViewController.swift
//  MedicineReminder
//
//  Created by Marian on 6/24/17.
//  Copyright © 2017 Marian. All rights reserved.
//

import UIKit
import TextFieldEffects
import MBProgressHUD


class AddPatientViewController: UIViewController {

    // MARK: - IBOutlet
    
    @IBOutlet weak var emailTextField: HoshiTextField!
    @IBOutlet weak var nameTextField: HoshiTextField!
    @IBOutlet weak var phoneTextField: HoshiTextField!

    // MARK: - Class Properties
    
    var progressView : MBProgressHUD?
    var presenter : AddPatientPresenterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = AddPatientPresenter.init(view: self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


    @IBAction func addPatient(_ sender: Any) {
        presenter?.addPatientToCurrentNurseWith(email: emailTextField.text!, name: nameTextField.text!, phone: phoneTextField.text!)
    }
}

extension AddPatientViewController: AddPatientViewProtocol{

    func successWith(msg: String){
        alert(message: msg)

    }
    
    func showErrorMsg(msg: String){
        alert(message: msg)

    }
    
    func showProgressBar(){
        progressView = self.showGlobalProgressHUDWithTitle(view: self.view, title: nil)

    }
    
    func hideProgressBar(){
        self.progressView!.hide(animated: false)
        self.progressView = nil

    }
    
}
