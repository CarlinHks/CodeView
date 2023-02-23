//
//  GFRepoItemVC.swift
//  CodeView
//
//  Created by Carlos Pacheco on 22/02/23.
//

import UIKit

class GFRepoItemVC: GFItemInfoVC {

  override func viewDidLoad() {
    super.viewDidLoad()
    configureItems()
  }

  private func configureItems() {
    itemInfoViewOne.set(itemInfoType: .repos, withCount: user.publicRepos)
    itemInfoViewTwo.set(itemInfoType: .gists, withCount: user.publicGists)
    actionButton.set(backgroungColor: .systemPurple, title: "GitHub Profile")
  }

  override func actionButtonTapped() {
    delegate.didTapGitHubProfile(for: user)
  }

}
