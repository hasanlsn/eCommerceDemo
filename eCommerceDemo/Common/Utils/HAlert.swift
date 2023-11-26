//
//  HAlert.swift
//  eCommerceDemo
//
//  Created by Hasan Ali Asan on 26.11.2023.
//

import UIKit

class HAlert: NSObject {
    static func showSystemAlert(title: String? = nil,
                                message: String? = nil,
                                buttonTitle: String? = "Tamam",
                                vc: UIViewController? = nil,
                                completion: (()->())? = nil) -> Void {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let firstAction = UIAlertAction(title: buttonTitle, style: .default) { (_) in
            if completion != nil {
                completion!()
            }
        }
        
        alert.addAction(firstAction)
        
        let viewController = vc ?? UIViewController.topViewController()
        DispatchQueue.main.async {
            viewController?.present(alert, animated: true, completion: nil)
        }
    }
}
