//
//  MedicinesListViewController.swift
//  MedicineReminder
//
//  Created by Marian on 6/23/17.
//  Copyright © 2017 Marian. All rights reserved.
//

import UIKit
import MBProgressHUD


class MedicinesListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Class Properties
    
    var progressView : MBProgressHUD?
    var presenter : MedicinesListPresenterProtocol?
    var medicines = [Medicine]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = MedicinesListPresenter(view: self)
        presenter?.getMedicinesList()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func addNewMedicine(_ sender: Any) {
        
        let alertController = UIAlertController(title: "New Medicine", message: nil, preferredStyle: UIAlertControllerStyle.alert)
        alertController.addTextField { (textField : UITextField) -> Void in
            textField.placeholder = "Name"
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let okAction = UIAlertAction(title: "Add", style: .default) {[weak self] (result : UIAlertAction) -> Void in
            
            let medicineName = alertController.textFields?.last?.text
            self?.presenter?.addNewMedicine(name: medicineName!)
            alertController.dismiss(animated: true, completion: nil)

        }
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
    }
    

}


extension MedicinesListViewController: UITableViewDataSource
{
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return medicines.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = medicines[indexPath.row].name
        
        return cell
        
    }
    
    
}

// MARK: - MedicinesListViewProtocol

extension MedicinesListViewController: MedicinesListViewProtocol{
    
    func successWith(medicines: [Medicine]){
        
            self.medicines = medicines
            self.tableView.reloadData()
        
    }
    
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
        
    }
}
