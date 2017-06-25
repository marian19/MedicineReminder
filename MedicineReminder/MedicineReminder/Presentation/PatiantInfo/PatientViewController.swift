//
//  PatientViewController.swift
//  MedicineReminder
//
//  Created by Marian on 6/24/17.
//  Copyright © 2017 Marian. All rights reserved.
//

import UIKit
import DZNEmptyDataSet
import MBProgressHUD

class PatientViewController: UIViewController {
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var phoneLable: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Class Properties
    
    var patient: Patient?
    var medicines = [PatientMedicine]()
    var progressView : MBProgressHUD?
    var presenter : PatientMedicinesPresenterProtocol?
    
    // MARK: - Class methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getPatientMedicinesList()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupViewController()  {
        
        self.tableView.tableFooterView = UIView.init()
        presenter = PatientPresenter(view: self)
        
        // add addbutton to navigationItem
        let addButton   = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.add, target: self,action:#selector(addMedicine))
        self.navigationItem.rightBarButtonItem = addButton
        
        // set patient info
        nameLabel.text = patient?.name
        emailLabel.text = patient?.email
        phoneLable.text = patient?.phone
    }
    
    func getPatientMedicinesList(){
        presenter?.getMedicinesForPatient(email: (patient?.email)!)
    }
    
    // rightBarButtonItem "add" selector
    func addMedicine(sender: UIBarButtonItem) {
        self.performSegue(withIdentifier: "addMedicine", sender: sender)
    }
    
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addMedicine" {
            
            // pass the selected patient to the AddMedicineViewController
            let addMedicineViewController = segue.destination as! AddMedicineViewController
            addMedicineViewController.patient = patient
        }
    }
}

// MARK: -  DZNEmptyDataSetSource implementation

extension PatientViewController: DZNEmptyDataSetSource{
    
    func title(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString? {
        let str = "No medicine added yet for this Patient"
        let attrs = [NSFontAttributeName: UIFont.preferredFont(forTextStyle: UIFontTextStyle.headline)]
        return NSAttributedString(string: str, attributes: attrs)
    }
    
    func description(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString? {
        let str = "You can start adding medicine from the add button"
        let attrs = [NSFontAttributeName: UIFont.preferredFont(forTextStyle: UIFontTextStyle.body)]
        return NSAttributedString(string: str, attributes: attrs)
    }
}

// MARK: -  UITableViewDataSource implementation

extension PatientViewController: UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Patient Medicines"
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return medicines.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! PatientMedicineTableViewCell
        
        cell.nameLabel.text = medicines[indexPath.row].medicine?.name
        let date: Date = medicines[indexPath.row].time! as Date
        cell.dateLabel.text = date.toString(format: "MMMM dd yyyy hh:mm aa")
        cell.doseLabel.text = medicines[indexPath.row].dosage
        cell.priorityLabel.text = medicines[indexPath.row].priority
        
        return cell
        
    }
    
    
}

// MARK: -  PatientMedicinesViewProtocol implementation

extension PatientViewController: PatientMedicinesViewProtocol{
    
    func successWith(medicines: [PatientMedicine]){
        
        self.medicines = medicines
        self.tableView.reloadData()
        
    }
    
    
    func showErrorMsg(msg : String){
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
