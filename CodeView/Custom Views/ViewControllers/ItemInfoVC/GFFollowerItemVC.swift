//
//  GFFollowerItemVC.swift
//  CodeView
//
//  Created by Carlos Pacheco on 22/02/23.
//

import UIKit

protocol FollowerInfoVCDelegate: AnyObject {
  func didTapGetFollowers(for user: User)
}

class GFFollowerItemVC: GFItemInfoVC {

  weak var delegate: FollowerInfoVCDelegate!

  init(user: User, delegate: FollowerInfoVCDelegate) {
    super.init(user: user)

    self.delegate = delegate
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureItems()
  }

  private func configureItems() {
    itemInfoViewOne.set(itemInfoType: .followers, withCount: user.followers)
    itemInfoViewTwo.set(itemInfoType: .following, withCount: user.following)
    actionButton.set(color: .systemGreen, title: "GitHub Followers", systemImageName: "person.3")
  }

  override func actionButtonTapped() {
    delegate.didTapGetFollowers(for: user)
  }

}
