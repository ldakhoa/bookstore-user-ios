//
//  HomeViewController.swift
//  bsuser
//
//  Created by Khoa Le on 11/10/2020.
//

import JGProgressHUD
import UIKit

// MARK: - HomeViewController

final class HomeViewController: UIViewController {

  // MARK: Internal

  @IBOutlet weak var locationTopView: LocationTopView!
  @IBOutlet weak var tableView: UITableView!

  let headerID = "headerID"
  let cellsID: [String] = [
    "cellId1",
    "cellId2",
    "cellId3",
    "cellId4",
    "cellId5",
  ]

  var recommendBook1 = [Book]()
  var recommendBook2 = [Book]()
  var recommendBook3 = [Book]()
  var recommendBook4 = [Book]()
  var recommendBook5 = [Book]()

  @IBOutlet var searchGradientView: SearchGradientView! {
    didSet {
      searchGradientView.searchTextField.isUserInteractionEnabled = false
      searchGradientView.layoutForOtherViewController()
    }
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    view.backgroundColor = Styles.Colors.White.normal
    searchGradientView.addGestureRecognizer(UITapGestureRecognizer(
      target: self,
      action: #selector(didTappedSearchGradientView)
    ))

    tableView.register(HomePageHeader.self, forCellReuseIdentifier: headerID)
    tableView.register(BookDetailRecommendationCell.self, forCellReuseIdentifier: cellsID[0])
    tableView.register(BookDetailRecommendationCell.self, forCellReuseIdentifier: cellsID[1])
    tableView.register(BookDetailRecommendationCell.self, forCellReuseIdentifier: cellsID[2])
    tableView.register(BookDetailRecommendationCell.self, forCellReuseIdentifier: cellsID[3])
    tableView.register(BookDetailRecommendationCell.self, forCellReuseIdentifier: cellsID[4])

    tableView.dataSource = self
    tableView.delegate = self
    fetchData()
  }

  // MARK: Private

  private func fetchData() {
    let dispatchGroup = DispatchGroup()
    let hud = JGProgressHUD(style: .dark)
    hud.show(in: view)

    dispatchGroup.enter()
    NetworkManagement.getRecommendBooks { code, data in
      if code == ResponseCode.ok.rawValue {
        dispatchGroup.leave()
        self.recommendBook1 = Book.parseRecommendBooksData(json: data)
      } else {
        self.presentErrorAlert(with: data)
      }
    }

    dispatchGroup.enter()
    NetworkManagement.getRecommendBooks { code, data in
      if code == ResponseCode.ok.rawValue {
        dispatchGroup.leave()
        self.recommendBook2 = Book.parseRecommendBooksData(json: data)
      } else {
        self.presentErrorAlert(with: data)
      }
    }

    dispatchGroup.enter()
    NetworkManagement.getRecommendBooks { code, data in
      if code == ResponseCode.ok.rawValue {
        dispatchGroup.leave()
        self.recommendBook3 = Book.parseRecommendBooksData(json: data)
      } else {
        self.presentErrorAlert(with: data)
      }
    }

    dispatchGroup.enter()
    NetworkManagement.getRecommendBooks { code, data in
      if code == ResponseCode.ok.rawValue {
        dispatchGroup.leave()
        self.recommendBook4 = Book.parseRecommendBooksData(json: data)
      } else {
        self.presentErrorAlert(with: data)
      }
    }

    dispatchGroup.enter()
    NetworkManagement.getRecommendBooks { code, data in
      if code == ResponseCode.ok.rawValue {
        dispatchGroup.leave()
        self.recommendBook5 = Book.parseRecommendBooksData(json: data)
      } else {
        self.presentErrorAlert(with: data)
      }
    }

    dispatchGroup.notify(queue: .main) {
      self.tableView.reloadData()
      hud.dismiss()
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

extension HomeViewController: UITableViewDataSource {

  func numberOfSections(in tableView: UITableView) -> Int {
    2
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    section == 0 ? 1 : cellsID.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if indexPath.section == 0 {
      guard let cell = tableView.dequeueReusableCell(withIdentifier: headerID, for: indexPath) as? HomePageHeader else { return UITableViewCell() }
      cell.homeHeaderHorizontalController.collectionView.reloadData()
      return cell
    }
    if indexPath.section == 1 {
      switch indexPath.row {
      case 0:
        guard let cell = tableView.dequeueReusableCell(
          withIdentifier: cellsID[0],
          for: indexPath
        ) as? BookDetailRecommendationCell else { return UITableViewCell() }
        cell.selectionStyle = .none
        cell.bookDetailRecommendHorizontalController.recommendBooks = recommendBook1
        cell.bookDetailRecommendHorizontalController.homeDelegate = self
        cell.titleLabel.text = "Books you may like"
        return cell
      case 1:
        guard let cell = tableView.dequeueReusableCell(
          withIdentifier: cellsID[1],
          for: indexPath
        ) as? BookDetailRecommendationCell else { return UITableViewCell() }
        cell.selectionStyle = .none
        cell.bookDetailRecommendHorizontalController.recommendBooks = recommendBook2
        cell.bookDetailRecommendHorizontalController.homeDelegate = self
        cell.titleLabel.text = "Related to Items You've Viewed"
        return cell
      case 2:
        guard let cell = tableView.dequeueReusableCell(
          withIdentifier: cellsID[2],
          for: indexPath
        ) as? BookDetailRecommendationCell else { return UITableViewCell() }
        cell.selectionStyle = .none
        cell.bookDetailRecommendHorizontalController.recommendBooks = recommendBook3
        cell.bookDetailRecommendHorizontalController.homeDelegate = self
        cell.titleLabel.text = "Best books of 2020"
        return cell
      case 3:
        guard let cell = tableView.dequeueReusableCell(
          withIdentifier: cellsID[3],
          for: indexPath
        ) as? BookDetailRecommendationCell else { return UITableViewCell() }
        cell.selectionStyle = .none
        cell.bookDetailRecommendHorizontalController.recommendBooks = recommendBook4
        cell.bookDetailRecommendHorizontalController.homeDelegate = self
        cell.titleLabel.text = "More items to consider"
        return cell
      case 4:
        guard let cell = tableView.dequeueReusableCell(
          withIdentifier: cellsID[4],
          for: indexPath
        ) as? BookDetailRecommendationCell else { return UITableViewCell() }
        cell.selectionStyle = .none
        cell.bookDetailRecommendHorizontalController.recommendBooks = recommendBook5
        cell.bookDetailRecommendHorizontalController.homeDelegate = self
        cell.titleLabel.text = "Books You May Have Missed"
        return cell
      default:
        return UITableViewCell()
      }
    }
    return UITableViewCell()
  }
}

// MARK: UITableViewDelegate

extension HomeViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    if indexPath.section == 0 {
      return 300
    } else {
      return 396
    }
  }
}

// MARK: BookDetailRecommendHorizontalControllerHomeDelegate

extension HomeViewController: BookDetailRecommendHorizontalControllerHomeDelegate {
  func didSelectedBook(_ book: Book) {
    let bookDetailController = BookDetailController()
    bookDetailController.book = book
    let navVC = UINavigationController(rootViewController: bookDetailController)
    navVC.modalPresentationStyle = .fullScreen
    present(navVC, animated: true)
  }
}
