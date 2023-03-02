//
//  UITableView+Ext.swift
//  CodeView
//
//  Created by Carlos Pacheco on 28/02/23.
//

import UIKit

extension UITableView {

  func reloadDataOnMainThread() {
    DispatchQueue.main.async {
      self.reloadData()
    }
  }

  func removeExcessCells() {
    tableFooterView = UIView(frame: .zero)
  }

}
