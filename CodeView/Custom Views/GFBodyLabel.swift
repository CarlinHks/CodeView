//
//  GFBodyLabel.swift
//  CodeView
//
//  Created by Carlos Pacheco on 15/02/23.
//

import UIKit

class GFBodyLabel: UILabel {

  override init(frame: CGRect) {
    super.init(frame: frame)

    configure()
  }

  init(textAlignment: NSTextAlignment) {
    super.init(frame: .zero)

    self.textAlignment = textAlignment

    configure()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func configure() {
    textColor = .secondaryLabel
    font = UIFont.preferredFont(forTextStyle: .body)
    adjustsFontSizeToFitWidth = true
    minimumScaleFactor = 0.75
    lineBreakMode = .byWordWrapping
    translatesAutoresizingMaskIntoConstraints = false
  }

}
