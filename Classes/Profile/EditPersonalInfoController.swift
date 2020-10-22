//
//  EditPersonalInfoController.swift
//  bsuser
//
//  Created by Khoa Le on 13/10/2020.
//

import UIKit

final class EditPersonalInfoController: UITableViewController {

    // MARK: Internal

    var user: User?

    let sectionData: [String] = [
        "Name",
        "Gender",
        "Birth date",
        "Email",
        "Phone number",
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Edit personal info"

        tableView.backgroundColor = UIColor(white: 0.95, alpha: 1) // lightGray
        tableView.tableFooterView = UIView()
        tableView.keyboardDismissMode = .interactive

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

    override func numberOfSections(in _: UITableView) -> Int {
        return 5
    }

    override func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return 1
    }

    override func tableView(_: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = EditPersonalInfoCell(style: .default, reuseIdentifier: nil)
        guard let user = user else { return UITableViewCell() }
        switch indexPath.section {
        case 0:
            cell.textField.placeholder = "Enter name"
//            cell.textLabel?.text = "Khoa Le"
        case 1:
            cell.textField.placeholder = "Select Gender"
            cell.textLabel?.text = user.gender
        case 2:
            cell.textField.placeholder = "Select birthdate"
        case 3:
            cell.textField.placeholder = "Edit email"
            cell.textField.text = user.email
        case 4:
            cell.textField.placeholder = "Enter phone number"
            cell.textField.text = "\(user.phone)"
        default:
            ()
        }
        return cell
    }

    override func tableView(_: UITableView, heightForRowAt _: IndexPath) -> CGFloat {
        return 44
    }

    override func tableView(_: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = EditPersonalInfoHeaderView()
        headerView.label.text = sectionData[section]

        return headerView
    }

    override func tableView(_: UITableView, heightForHeaderInSection _: Int) -> CGFloat {
        return 40
    }

    // MARK: Private

    @objc
    private func didTappedBackButton() {
        navigationController?.popViewController(animated: true)
    }

}
