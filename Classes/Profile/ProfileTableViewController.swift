//
//  ProfileTableViewController.swift
//  bsuser
//
//  Created by Khoa Le on 11/10/2020.
//

import UIKit

final class ProfileTableViewController: UITableViewController {

    private let datasource: [String] = [
        "My orders",
        "My favorite",
        "Shipping addresses",
        "Payment methods",
        "My reviews",
        "Settings",
    ]

    private let cellID = "ProfileCell"

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.backgroundColor = Styles.Colors.background.color
        tableView.tableFooterView = UIView()
        tableView.isScrollEnabled = false
        
        let nib = UINib(nibName: "ProfileCell", bundle: nil)

        tableView.register(nib, forCellReuseIdentifier: cellID)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datasource.count + 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! ProfileCell
        if indexPath.row == 6 {
            let logoutCell = LogoutCell(style: .default, reuseIdentifier: nil)
            return logoutCell
        } else {
            cell.titleLabel.text = datasource[indexPath.row]
        }

        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 72
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return ProfileHeaderView()
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 100
    }

}
