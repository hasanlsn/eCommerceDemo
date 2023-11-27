//
//  HAlert.swift
//  eCommerceDemo
//
//  Created by Hasan Ali Asan on 26.11.2023.
//

import UIKit

class HAlert: NSObject {
    typealias VoidCallback = (()->())
    
    static func showSystemAlert(title: String? = nil,
                                message: String? = nil,
                                buttonTitle: String? = "Tamam",
                                vc: UIViewController? = nil,
                                completion: VoidCallback? = nil) -> Void {
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
    
    static func showSystemAlert(title: String?,
                                message: String?,
                                leftButton: String?,
                                rightButton: String?,
                                vc: UIViewController,
                                style: UIAlertController.Style = .alert,
                                completionLeft: VoidCallback? = nil,
                                completionRight: VoidCallback? = nil) -> Void {
        let alert = UIAlertController(title: title, message: message, preferredStyle: style)
        let firstAction = UIAlertAction(title: leftButton, style: .default) { (_) in
            if completionLeft != nil {
                completionLeft!()
            }
        }
        
        let secondAction = UIAlertAction(title: rightButton, style: .default) { (_) in
            if completionRight != nil {
                completionRight!()
            }
        }
        
        alert.addAction(firstAction)
        alert.addAction(secondAction)
        DispatchQueue.main.async {
            vc.present(alert, animated: true, completion: nil)
        }
    }
}
