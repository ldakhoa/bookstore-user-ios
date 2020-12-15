//
//  ListOfAddressController.swift
//  bsuser
//
//  Created by Khoa Le on 05/11/2020.
//

import UIKit

// MARK: - ListOfAddressController

final class ListOfAddressController: UIViewController {

  // MARK: Internal

  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var dismissButton: UIButton!
  var user: User?

  override func viewDidLoad() {
    super.viewDidLoad()

    tableView.dataSource = self
    tableView.delegate = self
    tableView.backgroundColor = Styles.Colors.background.color
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)

    tableView.reloadData()
  }

  // MARK: Private

  @IBAction
  private func didTappedDismissButton(_ sender: Any) {
    dismiss(animated: true)
  }

  @IBAction
  private func didTappedAddNewShippingAddressButton(_ sender: Any) {
    let isInvalidShippingAddress = user?.phone ?? -1 < 10000
      && user?.address?.count ?? -1 < 1
      && user?.city?.count ?? -1 < 1
      && user?.district?.count ?? -1 < 1
      && user?.ward?.count ?? -1 < 1
    if !isInvalidShippingAddress {
      let alert = UIAlertController.configured(
        title: "Sorry for this inconvenience",
        message: "We have not support multi shipping address yet! Please edit your current shipping address",
        preferredStyle: .alert
      )
      alert.addAction(AlertAction.ok())
      present(alert, animated: true)
      return
    }
    editShippingAddress()
  }

  @IBAction
  private func didTappedEditButton(_ sender: Any) {
    let alert = UIAlertController.configured(preferredStyle: .actionSheet)
    alert.addActions([
      AlertAction.cancel(),
      AlertAction(AlertActionBuilder {
        $0.title = "Edit shipping address"
        $0.style = .default
      }).get { [weak self] _ in
        self?.editShippingAddress()
      },
      AlertAction(AlertActionBuilder {
        $0.title = "Delete shipping address"
        $0.style = .destructive
      }).get { [weak self] _ in
        self?.deleteShippingAddress()
      },
    ])
    present(alert, animated: true)
  }

  private func deleteShippingAddress() {
    print("Delete shipping address")
  }

  private func editShippingAddress() {
    guard let editAddressVC = AppSetting.Storyboards.Order.editAddressVC as? EditAddressController else { return }
    editAddressVC.user = user
    editAddressVC.delegate = self
    navigationController?.pushViewController(editAddressVC, animated: true)
  }

}

// MARK: UITableViewDataSource

extension ListOfAddressController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    let isInvalidShippingAddress = user?.phone ?? -1 < 10000
      && user?.address?.count ?? -1 < 1
      && user?.city?.count ?? -1 < 1
      && user?.district?.count ?? -1 < 1
      && user?.ward?.count ?? -1 < 1
    return isInvalidShippingAddress ? 0 : 1
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(
      withIdentifier: "ListOfAddressesCell",
      for: indexPath
    ) as? ListOfAddressesCell else { return UITableViewCell() }
    cell.user = user
    return cell
  }
}

// MARK: UITableViewDelegate

extension ListOfAddressController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    UITableView.automaticDimension
  }

  func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
    160
  }

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    dismiss(animated: true)
  }
}

// MARK: EditAddressControllerDelegate

extension ListOfAddressController: EditAddressControllerDelegate {
  func didTappedSaveButton(user: User) {
    self.user = user
    tableView.reloadData()
  }
}
