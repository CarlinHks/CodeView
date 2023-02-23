//
//  GFFollowerItemVC.swift
//  CodeView
//
//  Created by Carlos Pacheco on 22/02/23.
//

import UIKit

class GFFollowerItemVC: GFItemInfoVC {

  override func viewDidLoad() {
    super.viewDidLoad()
    configureItems()
  }

  private func configureItems() {
    itemInfoViewOne.set(itemInfoType: .followers, withCount: user.followers)
    itemInfoViewTwo.set(itemInfoType: .following, withCount: user.following)
    actionButton.set(backgroungColor: .systemGreen, title: "GitHub Followers")
  }

  override func actionButtonTapped() {
    delegate.didTapGetFollowers(for: user)
  }

}
