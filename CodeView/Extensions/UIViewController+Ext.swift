//
//  UIViewController+Ext.swift
//  CodeView
//
//  Created by Carlos Pacheco on 15/02/23.
//

import UIKit

extension UIViewController {

  func presentGFAlertOnMainThread(title: String, message: String, buttonTittle: String) {
    DispatchQueue.main.async {
      let alertVC = GFAlertVC(title: title, message: message, buttonTittle: buttonTittle)

      alertVC.modalPresentationStyle = .overFullScreen
      alertVC.modalTransitionStyle = .crossDissolve

      self.present(alertVC, animated: true)
    }
  }

}
