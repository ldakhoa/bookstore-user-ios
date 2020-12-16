//
//  CategoryViewController.swift
//  bsuser
//
//  Created by Khoa Le on 12/10/2020.
//

import JGProgressHUD
import UIKit

// MARK: - CategoryViewController

final class CategoryViewController: UIViewController {

  // MARK: Internal

  @IBOutlet var tableView: UITableView!

  var categories = [Category]()

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

    fetchCategories()
  }

  // MARK: Private

  private let cellID = "CategoryCell"

  private func fetchCategories() {
    let hud = JGProgressHUD(style: .dark)
    hud.show(in: view)
    NetworkManagement.getCategories { code, data in
      if code == ResponseCode.ok.rawValue {
        self.categories = Category.parseCategories(json: data)
        self.tableView.reloadData()
        hud.dismiss()
      } else {
        self.presentErrorAlert(title: "Cannot get categories", with: data)
      }
    }
  }

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

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    guard let bookListVC = AppSetting.Storyboards.BookList.bookListVC as? BookListViewController else { return }
    bookListVC.shouldPresentSearchController = false
    bookListVC.categoryName = categories[indexPath.row].categoryName
    bookListVC.isPresetedFromCategory = true
    navigationController?.pushViewController(bookListVC, animated: true)
    tableView.deselectRow(at: indexPath, animated: true)
  }
}
