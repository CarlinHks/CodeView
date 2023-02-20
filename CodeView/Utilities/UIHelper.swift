//
//  UIHelper.swift
//  CodeView
//
//  Created by Carlos Pacheco on 19/02/23.
//

import UIKit

struct UIHelper {

  static func createThreeColumnFlowLayout(in view: UIView) -> UICollectionViewLayout {
    let width = view.bounds.width
    let padding: CGFloat = 12
    let minItemSpacing: CGFloat = 10
    let availableWidth = width - (padding * 2) - (minItemSpacing * 2)
    let ItemWidth = availableWidth / 3

    let flowLayout = UICollectionViewFlowLayout()
    flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
    flowLayout.itemSize = CGSize(width: ItemWidth, height: ItemWidth + 40)


    return flowLayout
  }

}
