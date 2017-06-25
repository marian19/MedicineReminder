//
//  UIViewController+Extension.swift
//  RMS
//
//  Created by Marian on 1/17/17.
//  Copyright © 2017 Marian. All rights reserved.
//

import UIKit
import MBProgressHUD

extension UIViewController {

    func alert(message: String, title: String = "") {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func showGlobalProgressHUDWithTitle(view:UIView!,title: String?) -> MBProgressHUD{
        
        let hud = MBProgressHUD.showAdded(to: view, animated: true)
        
        
        if title == nil{
            hud.label.text = NSLocalizedString("Loading", comment: "Loading")
        }else{
            hud.label.text = title!
        }
        return hud
    }
}
