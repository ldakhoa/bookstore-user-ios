//
//  EditAddressController.swift
//  bsuser
//
//  Created by Khoa Le on 02/11/2020.
//

import UIKit

// MARK: - EditAddressController

final class EditAddressController: UIViewController {
    @IBOutlet var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self

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

    @objc
    func didTappedSaveButton() {
        navigationController?.popViewController(animated: true)
    }

    @objc
    func didTappedDismissButton() {
        navigationController?.popViewController(animated: true)
    }
}

// MARK: UITableViewDataSource

extension EditAddressController: UITableViewDataSource {
    func numberOfSections(in _: UITableView) -> Int {
        9
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
        case 0:
            let headerCell = tableView.dequeueReusableCell(
                withIdentifier: "HearderCell",
                for: indexPath
            )
            return headerCell
        case 1:
            cell.titleLabel.text = "Name"
            cell.editTextField.placeholder = "Enter name"
            cell.editTextField.text = "Khoa Le"
        case 2:
            cell.titleLabel.text = "Phone number"
            cell.editTextField.placeholder = "Enter phone number"
        case 3:
            cell.titleLabel.text = "Specific address"
            cell.editTextField.placeholder = "Enter specific address"
        case 4:
            cell.titleLabel.text = "City/Province"
            cell.editTextField.placeholder = "Select birth date"
        case 5:
            cell.titleLabel.text = "District"
            cell.editTextField.placeholder = "Enter district"
        case 6:
            cell.titleLabel.text = "Ward"
            cell.editTextField.placeholder = "Enter ward"
        case 7:
            cell.titleLabel.text = "ZIP code (Postal code)"
            cell.editTextField.placeholder = "Enter ZIP code"
        case 8:
            cell.titleLabel.text = "Country"
            cell.editTextField.placeholder = "Select country"
        default:
            ()
        }
        return cell
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
}
