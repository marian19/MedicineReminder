//
//  MedicinesListViewController.swift
//  MedicineReminder
//
//  Created by Marian on 6/23/17.
//  Copyright © 2017 Marian. All rights reserved.
//

import UIKit
import MBProgressHUD
import DZNEmptyDataSet

class MedicinesListViewController: UIViewController {
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Class Properties
    
    var progressView : MBProgressHUD?
    var presenter : MedicinesListPresenterProtocol?
    var medicines = [Medicine]()
    
    // MARK: - Class methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
       setupViewController()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupViewController()  {
        presenter = MedicinesListPresenter(view: self)
        presenter?.getMedicinesList()
        self.tableView.tableFooterView = UIView.init()
    }
    
    // MARK: - @IBAction
    
    @IBAction func addNewMedicine(_ sender: Any) {
        
        let alertController = UIAlertController(title: "New Medicine", message: nil, preferredStyle: UIAlertControllerStyle.alert)
        alertController.addTextField { (textField : UITextField) -> Void in
            textField.placeholder = "Name"
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let okAction = UIAlertAction(title: "Add", style: .default) {[weak self] (result : UIAlertAction) -> Void in
            
            let medicineName = alertController.textFields?.last?.text
            // add new medicine
            self?.presenter?.addNewMedicine(name: medicineName!)
            alertController.dismiss(animated: true, completion: nil)
            
        }
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    
}

// MARK: -  UITableViewDataSource implementation

extension MedicinesListViewController: UITableViewDataSource{
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return medicines.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = medicines[indexPath.row].name
        
        return cell
    }
    
}

// MARK: -  DZNEmptyDataSetSource implementation

extension MedicinesListViewController: DZNEmptyDataSetSource{
    
    func title(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString? {
        let str = "No medicine added yet"
        let attrs = [NSFontAttributeName: UIFont.preferredFont(forTextStyle: UIFontTextStyle.headline)]
        return NSAttributedString(string: str, attributes: attrs)
    }
    
    func description(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString? {
        let str = "You can start adding medicines to be able to view them"
        let attrs = [NSFontAttributeName: UIFont.preferredFont(forTextStyle: UIFontTextStyle.body)]
        return NSAttributedString(string: str, attributes: attrs)
    }
}

// MARK: - MedicinesListViewProtocol implementation

extension MedicinesListViewController: MedicinesListViewProtocol{
    
    // medicines: is the all medicines list
    func successWith(medicines: [Medicine]){
        
        self.medicines = medicines
        self.tableView.reloadData()
        
    }
    
    // medicine: is the new added medicine
    func successWith(medicine: Medicine,msg: String){
        self.medicines.append(medicine)
        self.tableView.reloadData()
        self.alert(message: msg)
        
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
