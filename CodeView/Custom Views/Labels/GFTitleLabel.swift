//
//  GFTitleLabel.swift
//  CodeView
//
//  Created by Carlos Pacheco on 15/02/23.
//

import UIKit

class GFTitleLabel: UILabel {

  override init(frame: CGRect) {
    super.init(frame: frame)

    configure()
  }

  convenience init(textAlignment: NSTextAlignment, fontSize: CGFloat) {
    self.init(frame: .zero)

    self.textAlignment = textAlignment
    self.font = UIFont.systemFont(ofSize: fontSize, weight: .bold)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func configure() {
    textColor = .label
    adjustsFontSizeToFitWidth = true
    minimumScaleFactor = 0.90
    lineBreakMode = .byTruncatingTail
    translatesAutoresizingMaskIntoConstraints = false
  }

}
