//
//  MyOrdersItemController.swift
//  bsuser
//
//  Created by Khoa Le on 07/11/2020.
//

import UIKit

// MARK: - MyOrdersItemControllerDelegate

protocol MyOrdersItemControllerDelegate: AnyObject {
  func didSelectItemCellAt(_ indexPath: IndexPath)
}

// MARK: - MyOrdersItemController

final class MyOrdersItemController: UITableViewController {

  weak var delegate: MyOrdersItemControllerDelegate?

  var orders = [Order]() {
    didSet {
      self.tableView.reloadData()
    }
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    tableView.register(
      UINib(nibName: "MyOrdersItemCell", bundle: nil),
      forCellReuseIdentifier: "MyOrdersItemCell"
    )
    tableView.backgroundColor = Styles.Colors.background.color
    tableView.separatorStyle = .none
    tableView.tableFooterView = UIView()
    tableView.contentInset = .init(top: 16, left: 0, bottom: 0, right: 0)
  }

  override func numberOfSections(in tableView: UITableView) -> Int {
    1
  }

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    orders.count
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(
      withIdentifier: "MyOrdersItemCell",
      for: indexPath
    ) as? MyOrdersItemCell else { return UITableViewCell() }
    cell.selectionStyle = .none
    cell.order = orders[indexPath.row]
    return cell
  }

  override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    240
  }

  override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
    200
  }

  override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    8
  }

  override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let view = UIView()
    view.backgroundColor = Styles.Colors.background.color
    return view
  }

  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    delegate?.didSelectItemCellAt(indexPath)
  }
}
