//
//  MedicienPopOverViewController.swift
//  MedicineReminder
//
//  Created by Marian on 6/24/17.
//  Copyright © 2017 Marian. All rights reserved.
//

import UIKit
import DZNEmptyDataSet
import MBProgressHUD

protocol MedicienPopOverViewControllerDelegate{
    func choosenMedicine(medicine: Medicine?)
}


class MedicienPopOverViewController: UIViewController {
    
    var delegate : MedicienPopOverViewControllerDelegate?
    var progressView : MBProgressHUD?
    var presenter : MedicinesListPresenterProtocol?
    var medicines = [Medicine]()
    
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter = MedicinesListPresenter(view: self)
        presenter?.getMedicinesList()
        self.tableView.tableFooterView = UIView.init()    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func cancelButtonTouchUpInside(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}

extension MedicienPopOverViewController: UITableViewDataSource,UITableViewDelegate
{
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return medicines.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = medicines[indexPath.row].name
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        if tableView.cellForRow(at: indexPath) != nil {
            
            if((self.delegate) != nil)
            {
                if medicines.count>0 {
                    delegate?.choosenMedicine(medicine: medicines[indexPath.row])
                    
                }else{
                    delegate?.choosenMedicine( medicine: nil)
                }
                self.dismiss(animated: true, completion: nil)
            }
            
        }
    }
    
    
}

extension MedicienPopOverViewController: DZNEmptyDataSetSource{
    
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

// MARK: - MedicinesListViewProtocol

extension MedicienPopOverViewController: MedicinesListViewProtocol{
    
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
        self.progressView = nil
        
    }
}


