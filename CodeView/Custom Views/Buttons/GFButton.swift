//
//  GFButton.swift
//  CodeView
//
//  Created by Carlos Pacheco on 30/01/23.
//

import UIKit

class GFButton: UIButton {

  override init(frame: CGRect) {
    super.init(frame: frame)

    configure()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  convenience init(backgroundColor: UIColor, title: String) {
    self.init(frame: .zero)

    self.backgroundColor = backgroundColor

    setTitle(title, for: .normal)
  }

  private func configure() {
    setTitleColor(.white, for: .normal)

    layer.cornerRadius      = 10
    titleLabel?.font        = UIFont.preferredFont(forTextStyle: .headline)
    translatesAutoresizingMaskIntoConstraints = false
  }

  func set(backgroungColor: UIColor, title: String) {
    backgroundColor = backgroungColor
    setTitle(title, for: .normal)
  }

}
