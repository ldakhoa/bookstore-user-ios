//
//  CategoryViewController.swift
//  bsuser
//
//  Created by Khoa Le on 12/10/2020.
//

import UIKit

final class CategoryViewController: UIViewController {
    private let datasource: [String] = [
        "Comics",
        "Romans",
        "Technology",
        "Fiction",
        "Poetry",
        "Novel",
        "History",
        "Law",
        "Education",
        "Science",
        "Letters",
        "Megazines",
    ]

    private let cellID = "CategoryCell"

    @IBOutlet var searchGradientView: SearchGradientView! {
        didSet {
            searchGradientView.searchTextField.placeholder = "Category"
        }
    }

    @IBOutlet var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = Styles.Colors.background.color
        tableView.backgroundColor = Styles.Colors.background.color
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
}

extension CategoryViewController: UITableViewDataSource {
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return datasource.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! CategoryCell
        cell.label.text = datasource[indexPath.row]
        return cell
    }
}

extension CategoryViewController: UITableViewDelegate {
    func tableView(_: UITableView, heightForRowAt _: IndexPath) -> CGFloat {
        return 50
    }
}
