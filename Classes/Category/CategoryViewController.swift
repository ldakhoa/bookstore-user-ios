//
//  CategoryViewController.swift
//  bsuser
//
//  Created by Khoa Le on 12/10/2020.
//

import UIKit

// MARK: - CategoryViewController

final class CategoryViewController: UIViewController {

  // MARK: Internal

  @IBOutlet var tableView: UITableView!

  @IBOutlet var searchGradientView: SearchGradientView! {
    didSet {
      searchGradientView.searchTextField.isUserInteractionEnabled = false
      searchGradientView.searchTextField.placeholder = "Category"
      searchGradientView.layoutForOtherViewController()
    }
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    view.backgroundColor = Styles.Colors.background.color
    tableView.backgroundColor = Styles.Colors.background.color
    tableView.delegate = self
    tableView.dataSource = self
    tableView.tableFooterView = UIView()

    searchGradientView.addGestureRecognizer(UITapGestureRecognizer(
      target: self,
      action: #selector(didTappedSearchGradientView)
    ))
    searchGradientView.isUserInteractionEnabled = true
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.setNavigationBarHidden(true, animated: animated)
  }

  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    navigationController?.setNavigationBarHidden(false, animated: animated)
  }

  // MARK: Private

  private let categories: [Category] = [
    Category(categoryName: "Computer and Technology"),
    Category(categoryName: "Children's Books"),
    Category(categoryName: "Food and Wine"),
    Category(categoryName: "History"),
    Category(categoryName: "Art and Photography"),
    Category(categoryName: "Romance"),
    Category(categoryName: "All"),
  ]

  private let cellID = "CategoryCell"

  @objc
  private func didTappedSearchGradientView() {
    guard let bookListVC = AppSetting.Storyboards.BookList.bookListVC as? BookListViewController else { return }
    bookListVC.shouldPresentSearchController = true
    navigationController?.pushViewController(bookListVC, animated: true)
  }

}

// MARK: UITableViewDataSource

extension CategoryViewController: UITableViewDataSource {
  func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
    categories.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as? CategoryCell else { return UITableViewCell() }
    cell.label.text = categories[indexPath.row].categoryName
    return cell
  }
}

// MARK: UITableViewDelegate

extension CategoryViewController: UITableViewDelegate {
  func tableView(_: UITableView, heightForRowAt _: IndexPath) -> CGFloat {
    50
  }
}
