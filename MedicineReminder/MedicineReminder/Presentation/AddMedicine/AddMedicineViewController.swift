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
    
    
    @IBOutlet weak var medicineTextField: HoshiTextField!
    @IBOutlet weak var timeTextField: HoshiTextField!
    @IBOutlet weak var priorityTextField: HoshiTextField!
    @IBOutlet weak var dosageTextField: HoshiTextField!
    
    
    var selectedMedicine :Medicine?
    var selectedDosageType :String = "pills"
    var selectedtime :Date?
    var selectedPriority :Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func selectedDosageButton(_ sender: DLRadioButton) {
        selectedDosageType = (sender.selected()?.titleLabel?.text)!
        
    }
    
    
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
        let datePicker = ActionSheetDatePicker(title: "Date:", datePickerMode: UIDatePickerMode.dateAndTime, selectedDate: Date(), target: self, action:#selector(datePicked(date:)), origin: textField)
        datePicker?.show()
    }
    
    func showPrioritesPicker(textField: UITextField) {
        let priorites = ["High","Medium","Low"]
        let prioritesActionSheetStringPicker = ActionSheetStringPicker(title: "Choose priority", rows: priorites, initialSelection:0 , doneBlock: { [weak self]
            picker, values, indexes in
            self?.selectedPriority = values
            self?.priorityTextField.text = indexes as! String?
            return
            }, cancel: { ActionMultipleStringCancelBlock in return }, origin: textField)
        
        prioritesActionSheetStringPicker?.show()
    }
    
    func datePicked(date:Date) {
        selectedtime = date
        timeTextField.text = date.toString(format: "MMMM dd yyyy hh:mm aa")
        
    }
    
}

extension AddMedicineViewController: UIPopoverPresentationControllerDelegate,MedicienPopOverViewControllerDelegate{
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        // return UIModalPresentationStyle.FullScreen
        return UIModalPresentationStyle.none
    }
    
    // MARK: - ResellerTableViewControllerDelegate
    
    func choosenMedicine(medicine: Medicine?){
        medicineTextField.text = medicine?.name
        selectedMedicine = medicine
        
    }
    
}

extension AddMedicineViewController: UITextFieldDelegate{
    
    public func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool{ // return NO to disallow editing.
        
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
