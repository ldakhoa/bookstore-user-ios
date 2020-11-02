//
//  ProfileTableViewController.swift
//  bsuser
//
//  Created by Khoa Le on 11/10/2020.
//

import JGProgressHUD
import UIKit

final class ProfileTableViewController: UITableViewController {
    // MARK: Internal

    var user = User()
    let hud = JGProgressHUD(style: .dark)

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.backgroundColor = Styles.Colors.background.color
        tableView.tableFooterView = UIView()
        tableView.isScrollEnabled = false

        let nib = UINib(nibName: "ProfileCell", bundle: nil)

        tableView.register(nib, forCellReuseIdentifier: cellID)
        tabBarController?.tabBar.isHidden = true

        fetchUserInfo()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    override func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return datasource.count + 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as? ProfileCell else { return UITableViewCell() }
        if indexPath.row == 6 {
            let logoutCell = LogoutCell(style: .default, reuseIdentifier: nil)
            return logoutCell
        } else {
            cell.titleLabel.text = datasource[indexPath.row]
        }

        return cell
    }

    override func tableView(_: UITableView, heightForRowAt _: IndexPath) -> CGFloat {
        return 72
    }

    override func tableView(_: UITableView, viewForHeaderInSection _: Int) -> UIView? {
        let headerView = ProfileHeaderView()
        headerView.nameLabel.text = user.username.capitalizingFirstLetter()
        headerView.showProfileButton.addTarget(
            self,
            action: #selector(didTapShowProfile),
            for: .touchUpInside
        )
        return headerView
    }

    override func tableView(_: UITableView, heightForHeaderInSection _: Int) -> CGFloat {
        return 100
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 6 {
            tableView.deselectRow(at: indexPath, animated: false)
            let alert = UIAlertController.configured(
                title: "Are you sure",
                message: "Are you sure you want to log out?",
                preferredStyle: .actionSheet
            )
            alert.addActions([
                AlertAction.cancel(),
                AlertAction(AlertActionBuilder {
                    $0.title = "Log out"
                    $0.style = .destructive
                }).get { [weak self] _ in
                    self?.logout()
                },
            ])
            present(alert, animated: true)
        }
    }

    // MARK: Private

    private let datasource: [String] = [
        "My orders",
        "My favorite",
        "Shipping addresses",
        "Payment methods",
        "My reviews",
        "Settings",
    ]

    private let cellID = "ProfileCell"

    private func logout() {
        AppSetting.shared.logout()
        AppSetting.shared.checkMainScreen()
    }

    @objc
    private func didTapShowProfile() {
        guard let editPersonalInfoController = AppSetting.Storyboards.Profile.editPersonalInfoVC as? EditPersonalInfoController else { return }
        editPersonalInfoController.user = user
        editPersonalInfoController.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(editPersonalInfoController, animated: true)
    }

    private func fetchUserInfo() {
        guard let userId = AppSecurity.shared.userID else { return }
        NetworkManagement.getInformationOfUserWith(id: userId) { code, data in
            if code == ResponseCode.ok.rawValue {
                self.user = User.parseData(json: data["user"])
                self.tableView.reloadData()
            } else {
                let errMessage = data["message"].stringValue
                let alert = UIAlertController.configured(
                    title: "Something wrong",
                    message: errMessage,
                    preferredStyle: .alert
                )
                alert.addAction(AlertAction.ok())
                self.present(alert, animated: true)
            }
        }
    }
}
