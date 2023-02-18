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

    navigationController?.navigationBar.prefersLargeTitles = true
    view.backgroundColor = .systemBackground

    NetworkManager.shared.getFollowers(for: username, page: 1) { result in
      switch result {
        case .success(let followers):
          print(followers.count)

        case .failure(let error):
          self.presentGFAlertOnMainThread(
            title: "Bad Stuff Happend",
            message: error.rawValue,
            buttonTitle: "ok"
          )
      }
    }
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)

//    navigationController?.isNavigationBarHidden = false
    navigationController?.setNavigationBarHidden(false, animated: true)
  }

}
