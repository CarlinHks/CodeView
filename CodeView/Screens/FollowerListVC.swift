//
//  FollowerListVC.swift
//  CodeView
//
//  Created by Carlos Pacheco on 15/02/23.
//

import UIKit

class FollowerListVC: UIViewController {

  var username: String!

  override func viewDidLoad() {
    super.viewDidLoad()

    navigationController?.isNavigationBarHidden = false
    navigationController?.navigationBar.prefersLargeTitles = true
    view.backgroundColor = .systemBackground
  }

}
