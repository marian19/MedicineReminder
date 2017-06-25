//
//  PatientsListViewController.swift
//  MedicineReminder
//
//  Created by Marian on 6/23/17.
//  Copyright © 2017 Marian. All rights reserved.
//

import UIKit
import MBProgressHUD
import DZNEmptyDataSet

class PatientsListViewController: UIViewController {
    
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Class Properties
    
    var progressView : MBProgressHUD?
    var presenter : PatientsListPresenterProtocol?
    var patients = [Patient]()
    
    // MARK: - Class methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewController()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getPatientList()
    }
    
    private func setupViewController()  {
        presenter = PatientsListPresenter.init(view: self)
        self.tableView.tableFooterView = UIView.init()
    }
    
    private func getPatientList() {
        presenter?.getPatientsListForCurrentNurse()
        
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "patientInfo" {
            // pass the selected patient to the PatientViewController
            if let indexPath = tableView.indexPathForSelectedRow {
                let patiantViewController = segue.destination as! PatientViewController
                patiantViewController.patient = patients[indexPath.row]
                
            }
        }
    }
    
    
}

// MARK: -  DZNEmptyDataSetSource implementation

extension PatientsListViewController: DZNEmptyDataSetSource{
    
    func title(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString? {
        let str = "No patients added yet"
        let attrs = [NSFontAttributeName: UIFont.preferredFont(forTextStyle: UIFontTextStyle.headline)]
        return NSAttributedString(string: str, attributes: attrs)
    }
    
    func description(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString? {
        let str = "You can start adding patients to be able to view them"
        let attrs = [NSFontAttributeName: UIFont.preferredFont(forTextStyle: UIFontTextStyle.body)]
        return NSAttributedString(string: str, attributes: attrs)
    }
}

// MARK: -  UITableViewDataSource implementation

extension PatientsListViewController: UITableViewDataSource{
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return patients.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = patients[indexPath.row].name
        
        return cell
        
    }
    
    
}

// MARK: -  PatientsListViewProtocol implementation

extension PatientsListViewController: PatientsListViewProtocol{
    
    func successWith(patients: [Patient]){
        self.patients = patients
        self.tableView.reloadData()
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

