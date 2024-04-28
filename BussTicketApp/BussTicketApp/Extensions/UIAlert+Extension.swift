//
//  UIAlert+Extension.swift
//  BusTicketApp
//
//  Created by alihizardere on 28.04.2024.
//

import UIKit

extension UIAlertController {

    static func showAlert(title: String?, message: String?, viewController: UIViewController) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Tamam", style: .default)
        
        alertController.addAction(okAction)
        viewController.present(alertController, animated: true, completion: nil)
    }
}
