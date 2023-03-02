//
//  FollowerListVC.swift
//  CodeView
//
//  Created by Carlos Pacheco on 15/02/23.
//

import UIKit

class FollowerListVC: GFDataLoadingVC {

  enum Section {
    case main
  }

  var username: String!
  var followers: [Follower] = []
  var filteredFollowers: [Follower] = []
  var page = 1
  var hasMoreFollowers = true
  var isSearching = false
  var isLoadingMoreFollowers = false

  var collectionView: UICollectionView!
  var dataSource: UICollectionViewDiffableDataSource<Section, Follower>!

  init(username: String) {
    super.init(nibName: nil, bundle: nil)

    self.username = username
    title = username
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()

    configureViewController()
    configureCollectionView()
    getFollowers(username: username, page: page)
    configureDataSource()
    configureSearchController()
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)

    //    navigationController?.isNavigationBarHidden = false
    navigationController?.setNavigationBarHidden(false, animated: true)
  }

  func configureViewController() {
    navigationController?.navigationBar.prefersLargeTitles = true
    view.backgroundColor = .systemBackground

    let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))

    navigationItem.rightBarButtonItem = addButton
    view.backgroundColor = .systemBackground
  }

  @objc func addButtonTapped() {
    showLoadingView()

    Task {
      do {
        let user = try await NetworkManager.shared.getUserInfo(for: username)

        dismissLoadingView()
        addUserToFavorites(user: user)
      } catch {
        dismissLoadingView()
        if let gfError = error as? GFError {
          presentGFAlert(title: "Something Went Wrong", message: gfError.rawValue)
        } else {
          presentDefaultError()
        }
      }
    }
  }

  func addUserToFavorites(user: User) {
    let favorite = Follower(login: user.login, avatarUrl: user.avatarUrl)

    PersistenceManager.updateWith(favorite: favorite, actionType: .add) { [weak self] error in
      guard let self else { return }
      guard let error else {
        self.presentGFAlertOnMainThread(
          title: "Success!",
          message: "You have successfully favorited this user👍",
          buttonTitle: "Hooray!"
        )

        return
      }

      self.presentGFAlertOnMainThread(
        title: "Something went wrong",
        message: error.rawValue
      )
    }
  }

  func configureCollectionView() {
    collectionView = UICollectionView(
      frame: view.bounds,
      collectionViewLayout: UIHelper.createThreeColumnFlowLayout(in: view)
    )

    collectionView.delegate = self
    collectionView.backgroundColor = .systemBackground

    view.addSubview(collectionView)
    collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseID)
  }

  func configureSearchController() {
    let searchController = UISearchController()

    searchController.searchResultsUpdater = self
    searchController.searchBar.placeholder = "Search for a username"
    searchController.obscuresBackgroundDuringPresentation = false
    navigationItem.searchController = searchController
  }

  func getFollowers(username: String, page: Int) {
    showLoadingView()
    isLoadingMoreFollowers = true

    Task {
      do {
        let followers = try await NetworkManager.shared.getFollowers(for: username, page: page)

        isLoadingMoreFollowers = false

        dismissLoadingView()
        updateUI(with: followers)
      } catch {
        isLoadingMoreFollowers = false

        dismissLoadingView()

        if let gfError = error as? GFError {
          presentGFAlert(title: "Bad stuff Happend", message: gfError.rawValue)
          presentGFAlert(title: "Bad stuff Happend", message: gfError.rawValue)
        } else {
          presentDefaultError()
        }
      }
    }
  }

  func updateUI(with followers: [Follower]) {
    if followers.count < 100 {
      self.hasMoreFollowers = false
    }

    self.followers.append(contentsOf: followers)

    guard !self.followers.isEmpty else {
      let message = "This user doesn't have followers. Go follow them 😀."

      DispatchQueue.main.async {
        self.showEmptyStateView(with: message, in: self.view)
      }

      return
    }

    self.updateData(on: self.followers)
  }

  func configureDataSource() {
    dataSource = UICollectionViewDiffableDataSource<Section, Follower>(
      collectionView: collectionView,
      cellProvider: { collectionView, indexPath, follower in
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.reuseID, for: indexPath) as! FollowerCell

        cell.set(follower: follower)

        return cell
      })
  }

  func updateData(on followers: [Follower]) {
    var snapshot = NSDiffableDataSourceSnapshot<Section, Follower>()
    snapshot.appendSections([.main])
    snapshot.appendItems(followers)

    DispatchQueue.main.async {
      self.dataSource.apply(snapshot, animatingDifferences: true)
    }
  }

}

extension FollowerListVC: UICollectionViewDelegate {

  func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
    let offsetY = scrollView.contentOffset.y
    let contentHeight = scrollView.contentSize.height
    let height = scrollView.frame.size.height

    if offsetY > (contentHeight - height) {
      guard hasMoreFollowers, !isLoadingMoreFollowers else { return }
      page += 1
      getFollowers(username: username, page: page)
    }
  }

  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let activeArray = isSearching ? filteredFollowers : followers
    let follower = activeArray[indexPath.item]
    let destVC = UserInfoVC()
    let navController = UINavigationController(rootViewController: destVC)

    destVC.delegate = self
    destVC.username = follower.login

    present(navController, animated: true)
  }

}

extension FollowerListVC: UISearchResultsUpdating {

  func updateSearchResults(for searchController: UISearchController) {
    guard let filter = searchController.searchBar.text,
          !filter.isEmpty
    else {
      isSearching = false

      filteredFollowers.removeAll()
      updateData(on: followers)

      return
    }

    filteredFollowers = followers.filter({ $0.login.lowercased().contains(filter.lowercased()) })

    isSearching = true
    updateData(on: filteredFollowers)
  }

}

extension FollowerListVC: UserListVCDelegate {

  func didRequestFollowers(for username: String) {
    self.username = username
    title = username
    page = 1
    followers.removeAll()
    collectionView.setContentOffset(.zero, animated: false)
    collectionView.scrollToItem(
      at: IndexPath(item: 0, section: 0),
      at: .top,
      animated: true
    )
    getFollowers(username: username, page: page)
  }

}
