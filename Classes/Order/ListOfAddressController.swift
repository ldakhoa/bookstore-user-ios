//
//  ListOfAddressController.swift
//  bsuser
//
//  Created by Khoa Le on 05/11/2020.
//

import JGProgressHUD
import UIKit

// MARK: - ListOfAddressController

final class ListOfAddressController: UIViewController {

  // MARK: Internal

  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var dismissButton: UIButton!

  let hud = JGProgressHUD(style: .dark)

  var addresses = [Address]() {
    didSet {
      tableView.reloadData()
    }
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    tableView.dataSource = self
    tableView.delegate = self
    tableView.backgroundColor = Styles.Colors.background.color
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)

    tableView.reloadData()
    fetchAddresses()
  }

  // MARK: Private

  private func fetchAddresses() {
    hud.show(in: view)
    NetworkManagement.getCartByUser { code, data in
      if code == ResponseCode.ok.rawValue {
        let cart = Cart.parseData(json: data["cart"])
        self.addresses = cart.addresses
        self.tableView.reloadData()
        self.hud.dismiss()
      } else {
        self.presentErrorAlert(title: "Cannot get addresses", with: data)
      }
    }
  }

  @IBAction
  private func didTappedDismissButton(_ sender: Any) {
    dismiss(animated: true)
  }

  @IBAction
  private func didTappedAddNewShippingAddressButton(_ sender: Any) {
    guard let editAddressVC = AppSetting.Storyboards.Order.editAddressVC as? EditAddressController else { return }
    navigationController?.pushViewController(editAddressVC, animated: true)
  }

}

// MARK: UITableViewDataSource

extension ListOfAddressController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    addresses.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(
      withIdentifier: "ListOfAddressesCell",
      for: indexPath
    ) as? ListOfAddressesCell else { return UITableViewCell() }
    cell.address = addresses[indexPath.row]
    cell.delegate = self
    return cell
  }
}

// MARK: UITableViewDelegate

extension ListOfAddressController: UITableViewDelegate {

  // MARK: Internal

  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    UITableView.automaticDimension
  }

  func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
    160
  }

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    hud.show(in: view)
    tableView.deselectRow(at: indexPath, animated: true)
    guard let addressId = addresses[indexPath.row].id else { return }
    putShippingAddress(with: addressId)
  }

  // MARK: Private

  private func putShippingAddress(with addressId: String) {
    NetworkManagement.putShippingAddress(with: addressId) { code, data in
      if code == ResponseCode.ok.rawValue {
        self.dismiss(animated: true)
      } else {
        self.presentErrorAlert(title: "Cannot choose shipping address", with: data)
        return
      }
    }
  }
}

// MARK: ListOfAddressesCellDelegate

extension ListOfAddressController: ListOfAddressesCellDelegate {

  // MARK: Internal

  func didTappedEditButton(at addressId: String) {
    let alert = UIAlertController.configured(preferredStyle: .actionSheet)
    alert.addActions([
      AlertAction.cancel(),
      AlertAction(AlertActionBuilder {
        $0.title = "Choose to default shipping address"
        $0.style = .default
      }).get { [weak self] _ in
        self?.putShippingAddress(with: addressId)
      },
      AlertAction(AlertActionBuilder {
        $0.title = "Edit shipping address"
        $0.style = .default
      }).get { [weak self] _ in
        self?.editShippingAddress(at: addressId)
      },
      AlertAction(AlertActionBuilder {
        $0.title = "Delete shipping address"
        $0.style = .destructive
      }).get { [weak self] _ in
        self?.deleteShippingAddress(at: addressId)
      },
    ])
    present(alert, animated: true)
  }

  // MARK: Private

  private func deleteShippingAddress(at addressId: String) {
    hud.show(in: view)
    NetworkManagement.deleteShippingAddress(at: addressId) { code, data in
      if code == ResponseCode.ok.rawValue {
        self.fetchAddresses()
        self.hud.dismiss()
      } else {
        self.presentErrorAlert(title: "Cannot delete shipping address", with: data)
        return
      }
    }
  }

  private func editShippingAddress(at addressId: String) {
    hud.show(in: view)
    NetworkManagement.getShippingAddress(at: addressId) { code, data in
      if code == ResponseCode.ok.rawValue {
        guard let editAddressVC = AppSetting.Storyboards.Order.editAddressVC as? EditAddressController else { return }
        editAddressVC.address = Address.parseData(json: data["address"])
        self.hud.dismiss()
        self.navigationController?.pushViewController(editAddressVC, animated: true)
      } else {
        self.presentErrorAlert(title: "Cannot edit address", with: data)
        self.hud.dismiss()
      }
    }
  }
}
