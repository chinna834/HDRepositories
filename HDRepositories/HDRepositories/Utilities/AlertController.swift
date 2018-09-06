//
//  AlertController.swift
//  HDRepositories
//
//  Created by Chinna Venkata Raju on 5/13/18.
//  Copyright © 2018 Chinna Venkata Raju. All rights reserved.
//

import Foundation
import UIKit

class AlertController {
    
    static let alertController = AlertController()
    
    func showAlertWithTitle(having title:String, message:String, target:AnyObject, successTitle:String, cancelTitle:String, successAction:@escaping (String)->(),cancelAction:@escaping ()->()){
        
        let alertController:UIAlertController = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
        
        if cancelTitle.count > 0 {
            let cancel:UIAlertAction = UIAlertAction.init(title: cancelTitle, style: .default, handler: { UIAlertAction in
                cancelAction()
                alertController.dismiss(animated: true, completion: nil)
            })
            
            alertController.addAction(cancel)
        }
        
        if successTitle.count > 0 {
            let success:UIAlertAction  = UIAlertAction.init(title: successTitle, style: .default, handler: { UIAlertAction in
                successAction("OK")
            })
            
            alertController .addAction(success)
        }
        
        target.present(alertController, animated: true, completion: nil)
    }
}
