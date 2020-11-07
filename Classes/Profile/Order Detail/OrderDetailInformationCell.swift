//
//  OrderDetailInformationCell.swift
//  bsuser
//
//  Created by Khoa Le on 07/11/2020.
//

import UIKit

// MARK: - SelfSizingTableView

class SelfSizingTableView: UITableView {
  //    var maxHeight = CGFloat.infinity
  //
  //    override var contentSize: CGSize {
  //        didSet {
  //            invalidateIntrinsicContentSize()
  //            setNeedsLayout()
  //        }
  //    }
  //
  //    override var intrinsicContentSize: CGSize {
  //        let height = min(maxHeight, contentSize.height)
  //        return CGSize(width: contentSize.width, height: height)
  //    }

  override var intrinsicContentSize: CGSize {
    self.layoutIfNeeded()
    return self.contentSize
  }

  override var contentSize: CGSize {
    didSet {
      self.invalidateIntrinsicContentSize()
    }
  }

  override func reloadData() {
    super.reloadData()
    invalidateIntrinsicContentSize()
  }
}

// MARK: - OrderDetailInformationCell

final class OrderDetailInformationCell: UITableViewCell {

  @IBOutlet weak var tableView: UITableView!

  override func awakeFromNib() {
    super.awakeFromNib()

    tableView.dataSource = self
    tableView.delegate = self
    tableView.backgroundColor = .red
  }
}

// MARK: UITableViewDataSource

extension OrderDetailInformationCell: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    3
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(
      withIdentifier: "OrderDetailBookCell",
      for: indexPath
    ) as? OrderDetailBookCell else { return UITableViewCell() }
    return cell
  }
}

// MARK: UITableViewDelegate

extension OrderDetailInformationCell: UITableViewDelegate {
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    200
  }

  func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
    frame.height
  }

}
