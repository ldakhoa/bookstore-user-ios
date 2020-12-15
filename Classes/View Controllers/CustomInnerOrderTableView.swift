//
//  CustomInnerOrderTableView.swift
//  bsuser
//
//  Created by Khoa Le on 15/12/2020.
//

import UIKit

// MARK: - CustomInnerOrderTableView

class CustomInnerOrderTableView: UITableView {

  // MARK: Lifecycle

  override init(frame: CGRect, style: UITableView.Style) {
    super.init(frame: frame, style: style)
    defaultInit()
  }

  required public init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    defaultInit()
  }

  // MARK: Open

  override open func layoutSubviews() {
    super.layoutSubviews()

    if nsHeightConstraint != nil {
      nsHeightConstraint?.constant = contentSize.height
    } else {
      fatalError("Set a nsHeightConstraint to set contentSize with same")
    }
  }

  // MARK: Internal

  func defaultInit() {
    keyboardDismissMode = .onDrag
    showsVerticalScrollIndicator = false
    showsHorizontalScrollIndicator = false
    tableFooterView = UIView(frame: .zero)
    tableHeaderView = UIView(frame: .zero)
    sectionFooterHeight = 0
    sectionHeaderHeight = 0
  }

}

extension UIView {

  var nsHeightConstraint: NSLayoutConstraint? {
    get {
      constraints.filter {
        if $0.firstAttribute == .height, $0.relation == .equal {
          return true
        }
        return false
      }.first
    }
    set{ setNeedsLayout() }
  }
}

extension UITableViewCell {

  var superTableView: UITableView? {

    var view = superview

    while view != nil && !(view is UITableView) {
      view = view?.superview
    }

    return view as? UITableView
  }
}
