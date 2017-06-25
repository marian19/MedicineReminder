//
//  AddMedicineViewController.swift
//  MedicineReminder
//
//  Created by Marian on 6/24/17.
//  Copyright © 2017 Marian. All rights reserved.
//

import UIKit
import DLRadioButton
import TextFieldEffects
import MBProgressHUD
import ActionSheetPicker_3_0

class AddMedicineViewController: UIViewController {
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var medicineTextField: HoshiTextField!
    @IBOutlet weak var timeTextField: HoshiTextField!
    @IBOutlet weak var priorityTextField: HoshiTextField!
    @IBOutlet weak var dosageTextField: HoshiTextField!
    
    // MARK: - Class Properties
    
    var progressView: MBProgressHUD?
    var presenter: AddMedicinePresenterProtocol?
    var patient: Patient?
    var selectedMedicine: Medicine?
    var selectedDosageType: String? = "pills"
    var selectedDosage: String?
    var selectedtime :Date?
    
    // MARK: - Class methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewController()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setupViewController()  {
        presenter = AddMedicinePresenter.init(view: self)
    }
    
    // medicine list popover view controller
    func showPopOverViewController(textField: UITextField) {
        let popController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MedicienPopOverViewController") as! MedicienPopOverViewController
        
        // set the presentation style
        popController.modalPresentationStyle = UIModalPresentationStyle.popover
        
        // set up the popover presentation controller
        popController.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection.up
        popController.popoverPresentationController?.delegate = self
        popController.popoverPresentationController?.sourceView = textField as UIView
        popController.popoverPresentationController?.sourceRect = textField.bounds
        popController.delegate = self
        // present the popover
        self.present(popController, animated: true, completion: nil)
    }
    
    func showDatePicker(textField: UITextField) {
        weak  var  datePicker = ActionSheetDatePicker(title: "Date:", datePickerMode: UIDatePickerMode.dateAndTime, selectedDate: Date(), target: self, action:#selector(datePicked(date:)), origin: textField)
        datePicker?.show()
    }
    
    func showPrioritesPicker(textField: UITextField) {
        let priorites = ["High","Medium","Low"]
        weak var prioritesActionSheetStringPicker = ActionSheetStringPicker(title: "Choose priority", rows: priorites, initialSelection:0 , doneBlock: { [weak self]
            picker, values, indexes in
            self?.priorityTextField.text = indexes as! String?
            return
            }, cancel: { ActionMultipleStringCancelBlock in return }, origin: textField)
        
        prioritesActionSheetStringPicker?.show()
    }
    
    func datePicked(date:Date) {
        selectedtime = date
        timeTextField.text = date.toString(format: "MMMM dd yyyy hh:mm aa")
        
    }
    
    // MARK: - @IBAction
    
    @IBAction func selectedDosageButton(_ sender: DLRadioButton) {
        selectedDosageType = (sender.selected()?.titleLabel?.text)!
        
    }
    
    @IBAction func addMedicine(_ sender: Any) {
        selectedDosage = "\(dosageTextField.text!) \(selectedDosageType!)"
        presenter?.addMedicine(medicine: selectedMedicine, patient: patient!, time: selectedtime, dosage: selectedDosage, priority: priorityTextField.text)
    }
    
}

// MARK: -  UIPopoverPresentationControllerDelegate,MedicienPopOverViewControllerDelegate implementation

extension AddMedicineViewController: UIPopoverPresentationControllerDelegate,MedicienPopOverViewControllerDelegate{
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.none
    }
    
    // MedicienPopOverViewControllerDelegate implementation
    func choosenMedicine(medicine: Medicine?){
        medicineTextField.text = medicine?.name
        selectedMedicine = medicine
    }
    
}

// MARK: -  UITextFieldDelegate implementation

extension AddMedicineViewController: UITextFieldDelegate{
    
    public func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool{
        
        if textField.tag == 1 {
            
            self.view.endEditing(true)
            showPopOverViewController(textField: textField)
            return false
            
        }else if textField.tag == 2 {
            
            self.view.endEditing(true)
            showDatePicker(textField: textField)
            return false
            
        }else if textField.tag == 3 {
            
            self.view.endEditing(true)
            showPrioritesPicker(textField: textField)
            return false
            
        }else {
            return true
        }
        
    }
    
}

// MARK: -  AddMedicineViewProtocol implementation

extension AddMedicineViewController: AddMedicineViewProtocol{
    
    func successWith(msg: String){
        
        let alertController = UIAlertController(title: nil, message: msg, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default) {
            action in
            self.navigationController?.popViewController(animated: true)
            
        }
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
        
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
