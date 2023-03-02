//
//  SearchVC.swift
//  CodeView
//
//  Created by Carlos Pacheco on 30/01/23.
//

import UIKit

class SearchVC: UIViewController {

  let logoImageView = UIImageView()
  let usernameTextField = GFTextField()
  let callToActionButton = GFButton(backgroundColor: .systemGreen, title: "Get Followers")

  var isUsernameEntered: Bool {
    !usernameTextField.text!.isEmpty
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()

    view.backgroundColor = .systemBackground
    configure()
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)

//    navigationController?.isNavigationBarHidden = true
    navigationController?.setNavigationBarHidden(true, animated: true)

    usernameTextField.text = ""
  }

  func configure() {
    view.addSubviews(logoImageView, usernameTextField, callToActionButton)

    configureLogoImageView()
    configureTextField()
    configureCallToActionButton()
    createDismissKeyboardTapGesture()
  }

  @objc func pushFollowerListVC() {
    guard isUsernameEntered else {
      presentGFAlertOnMainThread(
        title: "Empty Username",
        message: "Please enter a username. We need to know who to look for 😀.",
        buttonTitle: "Ok"
      )
      return
    }

    usernameTextField.resignFirstResponder()
    
    let followerListVC = FollowerListVC(username: usernameTextField.text!)

    navigationController?.pushViewController(followerListVC, animated: true)
  }

  func createDismissKeyboardTapGesture() {
    let tap = UITapGestureRecognizer(
      target: view,
      action: #selector(UIView.endEditing(_:))
    )

    view.addGestureRecognizer(tap)
  }

  func configureLogoImageView() {
    let logoSize: CGFloat = 200
    let topPadding: CGFloat = DeviceTypes.isSmallScreen ? 20 : 80
    
    logoImageView.translatesAutoresizingMaskIntoConstraints = false
    logoImageView.image = Images.ghLogo

    NSLayoutConstraint.activate([
      logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: topPadding),
      logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      logoImageView.heightAnchor.constraint(equalToConstant: logoSize),
      logoImageView.widthAnchor.constraint(equalToConstant: logoSize)
    ])
  }

  func configureTextField() {
    usernameTextField.delegate = self

    NSLayoutConstraint.activate([
      usernameTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 48),
      usernameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
      usernameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
      usernameTextField.heightAnchor.constraint(equalToConstant: 50)
    ])
  }

  func configureCallToActionButton() {
    callToActionButton.addTarget(self, action: #selector(pushFollowerListVC), for: .touchUpInside)

    NSLayoutConstraint.activate([
      callToActionButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
      callToActionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
      callToActionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
      callToActionButton.heightAnchor.constraint(equalToConstant: 50)
    ])
  }

}

extension SearchVC: UITextFieldDelegate {

  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    pushFollowerListVC()

    return true
  }
  
}
