//
//  BagViewController.swift
//  bsuser
//
//  Created by Khoa Le on 26/10/2020.
//

import UIKit

final class CartViewController: UIViewController {

    // MARK: Internal

    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Cart"
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.barTintColor = Styles.Colors.White.normal

        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = Styles.Colors.background.color
        tableView.separatorInset = .init(top: 0, left: 24, bottom: 0, right: 24)
        tableView.keyboardDismissMode = .interactive

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    // MARK: Private

    @IBAction
    private func didTappedCheckoutButton(_ sender: Any) {
        let orderNavController = AppSetting.Storyboards.Order.orderNavController
        orderNavController.modalPresentationStyle = .fullScreen
        present(orderNavController, animated: true)
    }

}

// MARK: - UITableViewDataSource

extension CartViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 1 ? 1 : 3
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: "CartCell",
                for: indexPath
            ) as? CartCell else { return UITableViewCell() }
            cell.selectionStyle = .none
            return cell
        } else if indexPath.section == 1 {
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: "PromoCodeCell",
                for: indexPath
            ) as? PromoCodeCell else { return UITableViewCell() }
            cell.selectionStyle = .none
            return cell
        }

        return UITableViewCell()
    }
}

// MARK: - UITableViewDelegate

extension CartViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.section == 0 ? 162 : 100
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 8
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = Styles.Colors.background.color
        return view
    }
}
