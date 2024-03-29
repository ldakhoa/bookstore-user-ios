//
//  EditAddressController.swift
//  bsuser
//
//  Created by Khoa Le on 02/11/2020.
//

import CountryPickerView
import JGProgressHUD
import UIKit

// MARK: - EditAddressController

final class EditAddressController: UIViewController {

  // MARK: Internal

  @IBOutlet var tableView: UITableView!
  let countryPickerView = CountryPickerView()
  var country: Country?
//  var user: User?
  var address = Address()

  override func viewDidLoad() {
    super.viewDidLoad()

    print("Address id: ", address.id)

    tableView.delegate = self
    tableView.dataSource = self

    countryPickerView.delegate = self

    navigationController?.navigationBar.prefersLargeTitles = true

    navigationItem.leftBarButtonItem = UIBarButtonItem(
      image: #imageLiteral(resourceName: "back"),
      style: .plain,
      target: self,
      action: #selector(didTappedDismissButton)
    )
    let rightBarButton = UIBarButtonItem(
      title: "Save",
      style: .plain,
      target: self,
      action: #selector(didTappedSaveButton)
    )
    rightBarButton.setTitleTextAttributes(
      [
        NSAttributedString.Key.font: Styles.Text.bodyBold.preferredFont,
        NSAttributedString.Key.foregroundColor: Styles.Colors.black.color,
        NSAttributedString.Key.underlineStyle: 1,
      ],
      for: .normal
    )
    navigationItem.rightBarButtonItem = rightBarButton
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.setNavigationBarHidden(false, animated: animated)

    tableView.reloadData()
  }

  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    navigationController?.setNavigationBarHidden(true, animated: animated)
  }

  // MARK: Private

  @objc
  private func didTappedSaveButton() {
    // TODO: - Validate field when address have phone + name field
    let valid = address.name?.count ?? -1 > 5
      && address.city?.count ?? -1 > 1
      && address.district?.count ?? -1 > 0
      && address.ward?.count ?? -1 > 0
      && address.country?.count ?? -1 > 0
      && address.contactPhoneNumber?.count ?? -1 > 9
      && address.userName.count > 2

    if !valid {
      let alert = UIAlertController.configured(
        title: "Please fill all fields",
        message: "We need your information to ship your books.",
        preferredStyle: .alert
      )
      alert.addAction(AlertAction.ok())
      present(alert, animated: true)
      return
    }
    let params: [String: Any] = [
      "userName": address.userName,
      "address": address.name ?? "",
      "phone": address.contactPhoneNumber ?? 0934512312,
      "city": address.city ?? "",
      "district": address.district ?? "",
      "ward": address.ward ?? 0,
      "zip_code": address.zipCode ?? 700000,
      "country": address.country ?? "Vietnam",
    ]
    let hud = JGProgressHUD(style: .dark)
    //		if address.id?.count ?? -1 < 2 {
    hud.show(in: view)
    NetworkManagement.postAddressInformation(with: params) { code, data in
      if code == ResponseCode.ok.rawValue {
        hud.dismiss()
        self.navigationController?.popViewController(animated: true)
      } else {
        self.presentErrorAlert(with: data)
      }
    }
    //		} else {
    //			hud.show(in: view)
    //			NetworkManagement.putShippingAddress(at: address.id ?? "", params: params) { code, data in
    //				if code == ResponseCode.ok.rawValue {
    //					hud.dismiss()
    //					self.navigationController?.popViewController(animated: true)
    //				} else {
    //					self.presentErrorAlert(with: data)
    //				}
    //			}
    //		}

    hud.dismiss()
  }

  @objc
  private func didTappedDismissButton() {
    navigationController?.popViewController(animated: true)
  }
}

// MARK: UITableViewDataSource

extension EditAddressController: UITableViewDataSource {

  // MARK: Internal

  func numberOfSections(in _: UITableView) -> Int {
    Sections.count
  }

  func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
    1
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(
      withIdentifier: "EditShippingAddressCell",
      for: indexPath
    ) as? EditShippingAddressCell else { return UITableViewCell() }
    switch indexPath.section {
    case Sections.header.rawValue:
      let headerCell = tableView.dequeueReusableCell(
        withIdentifier: "HearderCell",
        for: indexPath
      )
      return headerCell
    case Sections.name.rawValue:
      cell.titleLabel.text = Sections.name.getTitleText()
      cell.editTextField.placeholder = Sections.name.getPlaceHolderText()
      cell.editTextField.text = address.userName
      cell.editTextField.addTarget(self, action: #selector(handleNameChange), for: .editingChanged)
    case Sections.phoneNumber.rawValue:
      cell.titleLabel.text = Sections.phoneNumber.getTitleText()
      cell.editTextField.keyboardType = .phonePad
      cell.editTextField.text = address.contactPhoneNumber ?? "84"
      cell.editTextField.placeholder = Sections.phoneNumber.getPlaceHolderText()
      cell.editTextField.addTarget(
        self,
        action: #selector(handlePhoneNumberChange),
        for: .editingChanged
      )
    case Sections.specificAddress.rawValue:
      cell.titleLabel.text = Sections.specificAddress.getTitleText()
      cell.editTextField.placeholder = Sections.specificAddress.getPlaceHolderText()
      cell.editTextField.addTarget(
        self,
        action: #selector(handleAddressChange),
        for: .editingChanged
      )
      cell.editTextField.text = address.name
    case Sections.cityOrProvide.rawValue:
      cell.titleLabel.text = Sections.cityOrProvide.getTitleText()
      cell.editTextField.placeholder = Sections.cityOrProvide.getPlaceHolderText()
      cell.editTextField.addTarget(self, action: #selector(handleCityChange), for: .editingChanged)
      cell.editTextField.text = address.city
    case Sections.district.rawValue:
      cell.titleLabel.text = Sections.district.getTitleText()
      cell.editTextField.placeholder = Sections.district.getPlaceHolderText()
      cell.editTextField.addTarget(
        self,
        action: #selector(handleDistrictChange),
        for: .editingChanged
      )
      cell.editTextField.text = address.district
    case Sections.ward.rawValue:
      cell.titleLabel.text = Sections.ward.getTitleText()
      cell.editTextField.placeholder = Sections.ward.getPlaceHolderText()
      cell.editTextField.addTarget(self, action: #selector(handleWardChange), for: .editingChanged)
      cell.editTextField.text = address.ward
    case Sections.postalCode.rawValue:
      cell.titleLabel.text = Sections.postalCode.getTitleText()
      cell.editTextField.placeholder = Sections.postalCode.getPlaceHolderText()
      cell.editTextField.addTarget(
        self,
        action: #selector(handlePostalCodeChange),
        for: .editingChanged
      )
      cell.editTextField.text = "\(address.zipCode ?? 700000)"
    case Sections.country.rawValue:
      cell.titleLabel.text = Sections.country.getTitleText()
      cell.editTextField.placeholder = Sections.country.getPlaceHolderText()
      cell.editTextField.isUserInteractionEnabled = false
      cell.editTextField.text = address.country?.count ?? -1 < 1 ? country?.name : address.country
      cell.editTextField.addTarget(
        self,
        action: #selector(handleCountryChange),
        for: .editingChanged
      )
    default:
      ()
    }
    return cell
  }

  // MARK: Private

  private enum Sections: Int, CaseIterable {
    case header = 0
    case name = 1
    case phoneNumber = 2
    case specificAddress = 3
    case cityOrProvide = 4
    case district = 5
    case ward = 6
    case postalCode = 7
    case country = 8

    // MARK: Internal

    static let count = Sections.allCases.count

    func getTitleText() -> String {
      switch self {
      case .header:
        return ""
      case .name:
        return "Name"
      case .phoneNumber:
        return "Phone number"
      case .specificAddress:
        return "Specific address"
      case .cityOrProvide:
        return "City/Province"
      case .district:
        return "District"
      case .ward:
        return "Ward"
      case .postalCode:
        return "ZIP code (Postal code)"
      case .country:
        return "Country"
      }
    }

    func getPlaceHolderText() -> String {
      switch self {
      case .header:
        return ""
      case .name:
        return "Enter name"
      case .phoneNumber:
        return "Enter phone number"
      case .specificAddress:
        return "Enter specific address"
      case .cityOrProvide:
        return "Enter city/provide"
      case .district:
        return "Enter district"
      case .ward:
        return "Enter ward"
      case .postalCode:
        return "Enter ZIP code"
      case .country:
        return "Select country"
      }
    }
  }

  @objc
  private func handleCountryChange(textField: UITextField) {
    address.country = country?.name ?? "Vietnam"
  }

  @objc
  private func handleNameChange(textField: UITextField) {
    address.userName = textField.text ?? ""
  }

  @objc
  private func handlePhoneNumberChange(textField: UITextField) {
    address.contactPhoneNumber = textField.text ?? "84"
  }

  @objc
  private func handleAddressChange(textField: UITextField) {
    address.name = textField.text ?? ""
  }

  @objc
  private func handleCityChange(textField: UITextField) {
    address.city = textField.text ?? ""
  }

  @objc
  private func handleDistrictChange(textField: UITextField) {
    address.district = textField.text ?? ""
  }

  @objc
  private func handleWardChange(textField: UITextField) {
    address.ward = textField.text ?? ""
  }

  @objc
  private func handlePostalCodeChange(textField: UITextField) {
    address.zipCode = Int(textField.text ?? "") ?? 700000
  }

}

// MARK: UITableViewDelegate

extension EditAddressController: UITableViewDelegate {
  func tableView(_: UITableView, heightForRowAt _: IndexPath) -> CGFloat {
    UITableView.automaticDimension
  }

  func tableView(_: UITableView, estimatedHeightForRowAt _: IndexPath) -> CGFloat {
    100
  }

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    if indexPath.section == 8 {
      countryPickerView.showCountriesList(from: self)
    }
  }
}

// MARK: CountryPickerViewDelegate

extension EditAddressController: CountryPickerViewDelegate {
  func countryPickerView(_ countryPickerView: CountryPickerView, didSelectCountry country: Country) {
    self.country = country
    tableView.reloadData()
  }

  func navigationTitle(in countryPickerView: CountryPickerView) -> String? {
    "Select a Country"
  }
}
