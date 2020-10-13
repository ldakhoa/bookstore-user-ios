//
//  EditPersonalInfoController.swift
//  bsuser
//
//  Created by Khoa Le on 13/10/2020.
//

import UIKit
import BATabBarController

final class EditPersonalInfoController: UITableViewController {
    let sectionData: [String] = [
        "Name",
        "Gender",
        "Birth date",
        "Email",
        "Phone number",
    ]

    let baTabBarController = BATabBarController()

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Edit personal info"

        tableView.keyboardDismissMode = .interactive
        tableView.backgroundColor = Styles.Colors.backgroundEditPersonalInfo.color
        tableView.separatorStyle = .none

        tableView.allowsSelection = false
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: #imageLiteral(resourceName: "back"),
            style: .plain,
            target: self,
            action: #selector(didTappedBackButton)
        )

        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Save",
            style: .plain,
            target: self,
            action: #selector(didTappedBackButton)
        )
        navigationController?.navigationBar.tintColor = Styles.Colors.black.color
    }

    @objc
    private func didTappedBackButton() {
        navigationController?.popViewController(animated: true)
    }

    override func numberOfSections(in _: UITableView) -> Int {
        return sectionData.count
    }

    override func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return 1
    }

    override func tableView(_: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = EditPersonalInfoCell(style: .default, reuseIdentifier: nil)

        switch indexPath.section {
        case 0:
            cell.textField.placeholder = "Enter name"
        case 1:
            cell.textField.placeholder = "Select Gender"
        case 2:
            cell.textField.placeholder = "Select birthdate"
        case 3:
            cell.textField.placeholder = "Edit email"
        case 4:
            cell.textField.placeholder = "Enter phone number"
        default:
            ()
        }
        return cell
    }

    override func tableView(_: UITableView, heightForRowAt _: IndexPath) -> CGFloat {
        return 40
    }

    override func tableView(_: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = EditPersonalInfoHeaderView()
        headerView.label.text = sectionData[section]

        return headerView
    }

    override func tableView(_: UITableView, heightForHeaderInSection _: Int) -> CGFloat {
        return 40
    }
}
