//
//  HIndicator.swift
//  eCommerceDemo
//
//  Created by Hasan Ali Asan on 27.11.2023.
//

import SVProgressHUD

struct HIndicator {
    static func show() {
        UIApplication.resignAllResponders()
        
        DispatchQueue.main.async {
            SVProgressHUD.setDefaultStyle(.custom)
            SVProgressHUD.setForegroundColor(.color0551A0)
            SVProgressHUD.setBackgroundColor(.colorFAE14B)
            SVProgressHUD.setDefaultMaskType(.black)
            SVProgressHUD.show()
        }
    }
    
    static func hide() {
        DispatchQueue.main.async {
            SVProgressHUD.dismiss()
        }
    }
}
