//
//  OrderDetailInformationCell.swift
//  bsuser
//
//  Created by Khoa Le on 07/11/2020.
//

import UIKit

// MARK: - OrderDetailInformationCell

final class OrderDetailInformationCell: UITableViewCell {

  @IBOutlet weak var tableView: CustomInnerOrderTableView!

  var books = [Book]() {
    didSet {
      print("Book count", books.count)
      self.tableView.reloadData()
    }
  }

  override func awakeFromNib() {
    super.awakeFromNib()

    tableView.dataSource = self
    tableView.delegate = self
    tableView.isScrollEnabled = false
  }

  override func layoutSubviews() {
    super.layoutSubviews()

    tableView.layoutSubviews()
    superTableView?.beginUpdates()
    superTableView?.endUpdates()

  }

}

// MARK: UITableViewDataSource

extension OrderDetailInformationCell: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    books.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(
      withIdentifier: "OrderDetailBookCell",
      for: indexPath
    ) as? OrderDetailBookCell else { return UITableViewCell() }
    cell.book = books[indexPath.row]
    cell.selectionStyle = .none
    return cell
  }
}

// MARK: UITableViewDelegate

extension OrderDetailInformationCell: UITableViewDelegate {
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    210
  }
}
