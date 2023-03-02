//
//  GFRepoItemVC.swift
//  CodeView
//
//  Created by Carlos Pacheco on 22/02/23.
//

import UIKit

protocol RepoInfoVCDelegate: AnyObject {
  func didTapGitHubProfile(for user: User)
}

class GFRepoItemVC: GFItemInfoVC {

  weak var delegate: RepoInfoVCDelegate!

  init(user: User, delegate: RepoInfoVCDelegate) {
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
    itemInfoViewOne.set(itemInfoType: .repos, withCount: user.publicRepos)
    itemInfoViewTwo.set(itemInfoType: .gists, withCount: user.publicGists)
    actionButton.set(backgroungColor: .systemPurple, title: "GitHub Profile")
  }

  override func actionButtonTapped() {
    delegate.didTapGitHubProfile(for: user)
  }

}
