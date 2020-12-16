//
//  MyOrdersItemController.swift
//  bsuser
//
//  Created by Khoa Le on 07/11/2020.
//

import UIKit

// MARK: - MyOrdersItemControllerDelegate

protocol MyOrdersItemControllerDelegate: AnyObject {
  func didSelectItemCellAt(_ indexPath: IndexPath, with status: OrderStatus)
  func didTappedContinueShopping()
}

// MARK: - MyOrdersItemController

final class MyOrdersItemController: UITableViewController {

  // MARK: Internal

  weak var delegate: MyOrdersItemControllerDelegate?

  var isSelectedInStatus: OrderStatus?

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
    orders.count > 0 ? 8 : 400
  }

  override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let headerView = UIView()

    let imageView = UIImageView(image: UIImage(named: "cart_placeholder"))
    imageView.contentMode = .scaleAspectFill

    let label = UILabel(
      text: "You have no books in your shopping cart",
      font: Styles.Text.body.preferredFont,
      textColor: Styles.Colors.black.color,
      textAlignment: .center,
      numberOfLines: 2
    )

    let button = UIButton(type: .system)
    button.setTitle("Continue shopping", for: .normal)
    button.setTitleColor(Styles.Colors.White.normal, for: .normal)
    button.backgroundColor = Styles.Colors.primary.color
    button.layer.cornerRadius = 8
    button.titleLabel?.font = Styles.Text.button.preferredFont

    headerView.addSubview(label)
    headerView.addSubview(imageView)
    headerView.addSubview(button)

    label.anchor(
      top: imageView.bottomAnchor,
      leading: headerView.leadingAnchor,
      bottom: nil,
      trailing: headerView.trailingAnchor,
      padding: .init(top: 8, left: 24, bottom: 0, right: 24)
    )

    imageView.anchor(
      top: headerView.topAnchor,
      leading: nil,
      bottom: nil,
      trailing: nil,
      padding: .init(top: 8, left: 0, bottom: 0, right: 0),
      size: .init(width: 250, height: 250)
    )
    imageView.centerXAnchor.constraint(equalTo: headerView.centerXAnchor).isActive = true

    button.anchor(
      top: label.bottomAnchor,
      leading: label.leadingAnchor,
      bottom: nil,
      trailing: label.trailingAnchor,
      padding: .init(top: 24, left: 0, bottom: 0, right: 0),
      size: .init(width: 0, height: 50)
    )
    button.addTarget(self, action: #selector(didTappedContinueShopping), for: .touchUpInside)

    let view = UIView()
    view.backgroundColor = Styles.Colors.background.color
    return orders.count > 0 ? view : headerView
  }

  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    delegate?.didSelectItemCellAt(indexPath, with: isSelectedInStatus ?? .processing)
  }

  // MARK: Private

  @objc
  private func didTappedContinueShopping() {
    delegate?.didTappedContinueShopping()
  }
}
