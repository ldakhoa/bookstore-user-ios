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

  // MARK: Private

  @IBAction
  private func didTappedDismissButton(_ sender: Any) {
    dismiss(animated: true)
  }

  @IBAction
  private func didTappedAddNewShippingAddressButton(_ sender: Any) {
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
    1
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
