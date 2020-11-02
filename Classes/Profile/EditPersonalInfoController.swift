//
//  EditPersonalInfoController.swift
//  bsuser
//
//  Created by Khoa Le on 13/10/2020.
//

import UIKit

// MARK: - EditPersonalInfoController

final class EditPersonalInfoController: UIViewController {
    @IBOutlet var tableView: UITableView!
    var user: User?

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self

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

extension EditPersonalInfoController: UITableViewDataSource {
    func numberOfSections(in _: UITableView) -> Int {
        6
    }

    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: "EditPersonalInfoCell",
            for: indexPath
        ) as? EditPersonalInfoCell, let user = user else { return UITableViewCell() }
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
            cell.titleLabel.text = "Gender"
            cell.editTextField.placeholder = "Select Gender"
            cell.editTextField.text = user.gender
        case 3:
            cell.titleLabel.text = "Birth date"
            cell.editTextField.placeholder = "Select birth date"
        case 4:
            cell.titleLabel.text = "Email"
            cell.editTextField.placeholder = "Edit email"
            cell.editTextField.text = user.email
        case 5:
            cell.titleLabel.text = "Phone number"
            cell.editTextField.placeholder = "Enter phone number"
            cell.editTextField.text = "\(user.phone)"
        default:
            ()
        }
        return cell
    }
}

// MARK: UITableViewDelegate

extension EditPersonalInfoController: UITableViewDelegate {
    func tableView(_: UITableView, heightForRowAt _: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }

    func tableView(_: UITableView, estimatedHeightForRowAt _: IndexPath) -> CGFloat {
        100
    }
}
