//
//  SearchViewController.swift
//  bsuser
//
//  Created by Khoa Le on 12/10/2020.
//

import JGProgressHUD
import UIKit

// MARK: - BookListViewController

final class BookListViewController: UIViewController {

  // MARK: Internal

  var shouldPresentSearchController = false
  var books = [Book]()
  var isAscending = true
  var isChoosingPrice = false
  var isChoosingRatings = false
  var isPresetedFromCategory = false
  var category: String?

  @IBOutlet var tableView: UITableView!
  @IBOutlet var collectionView: UICollectionView!
  let filterDatasource: [String] = [
    "Sorted by: Ascending",
    "Category",
    "Price",
    "Rating",
  ]

  @IBOutlet var searchGradientView: SearchGradientView! {
    didSet {
      searchGradientView.searchTextField.isUserInteractionEnabled = false
      searchGradientView.layoutForBookListController()
    }
  }

  // MARK: - View Life Cycle

  override func viewDidLoad() {
    super.viewDidLoad()

    tableView.backgroundColor = Styles.Colors.background.color
    tableView.separatorStyle = .none
    tableView.delegate = self
    tableView.dataSource = self

    collectionView.dataSource = self
    collectionView.delegate = self

//    if shouldPresentSearchController {
//      didTappedSearchGradientView()
//      shouldPresentSearchController = false
//    }

    searchGradientView.addGestureRecognizer(UITapGestureRecognizer(
      target: self,
      action: #selector(didTappedSearchGradientView)
    ))

    searchGradientView.backButton.addTarget(
      self,
      action: #selector(didTappedBackButton),
      for: .touchUpInside
    )

    if isPresetedFromCategory {
      fetchBookByCategory()
    }
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)

    if searchGradientView.searchTextField.text?.count == 0 && shouldPresentSearchController {
      didTappedSearchGradientView()
      shouldPresentSearchController = false
    }
  }

  // MARK: Private

  private func fetchBookByCategory() {
    let hud = JGProgressHUD(style: .dark)
    NetworkManagement.getBookByCategory(category ?? "") { code, data in
      if code == ResponseCode.ok.rawValue {
        self.books = Book.parseData(json: data)
        self.tableView.reloadData()
        hud.dismiss()
      } else {
        self.presentErrorAlert(with: data)
      }
    }
  }

  @objc
  private func didTappedBackButton() {
    navigationController?.popViewController(animated: true)
  }

  @objc
  private func didTappedSearchGradientView() {
    guard let searchVC = AppSetting.Storyboards.Search.searchVC as? SearchViewController else { return }
    searchVC.modalPresentationStyle = .fullScreen
    searchVC.delegate = self
    present(searchVC, animated: true)
  }
}

// MARK: UITableViewDataSource

extension BookListViewController: UITableViewDataSource {
  func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
    books.count
//        return 1
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(
      withIdentifier: "BookListCell",
      for: indexPath
    ) as? BookListCell else { return UITableViewCell() }
    cell.selectionStyle = .none
    cell.book = books[indexPath.row]
    return cell
  }
}

// MARK: UITableViewDelegate

extension BookListViewController: UITableViewDelegate {
  func tableView(_: UITableView, heightForRowAt _: IndexPath) -> CGFloat {
    135 + 16 + 16
  }

  func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
    let bookDetailController = BookDetailController()
    bookDetailController.modalPresentationStyle = .fullScreen
    bookDetailController.book = books[indexPath.row]
    let navVC = UINavigationController(rootViewController: bookDetailController)
    navVC.modalPresentationStyle = .fullScreen
    present(navVC, animated: true)
  }
}

// MARK: UICollectionViewDataSource

extension BookListViewController: UICollectionViewDataSource {
  func numberOfSections(in _: UICollectionView) -> Int {
    1
  }

  func collectionView(_: UICollectionView, numberOfItemsInSection _: Int) -> Int {
    filterDatasource.count
  }

  func collectionView(
    _ collectionView: UICollectionView,
    cellForItemAt indexPath: IndexPath
  ) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(
      withReuseIdentifier: "FilterCell",
      for: indexPath
    ) as? FilterCell else { return UICollectionViewCell() }
    cell.textLabel.text = filterDatasource[indexPath.item]
    if indexPath.item == 0 {
      cell.textLabel.text = "Sorted by: \(isAscending ? "Ascending" : "Descending")"
      cell.iconImageView.image = UIImage(named: "swap")
    } else if indexPath.item == 1 {
      cell.iconImageView.image = UIImage(named: "down-arrow")
    } else if indexPath.item == 2 {
      cell.iconImageView.image = UIImage(named: "filter")
//            if isChoosingPrice {
//                cell.containerView.layer.borderColor = Styles.Colors.filterBorder.color.cgColor
//                cell.containerView.backgroundColor = Styles.Colors.filterBackground.color
//
//            } else {
//                cell.containerView.layer.borderColor = Styles.Colors.border.color.cgColor
//                cell.containerView.backgroundColor = Styles.Colors.White.normal
//            }
    } else if indexPath.item == 3 {
      cell.iconImageView.image = UIImage(named: "filter")
//            if isChoosingRatings {
      ////                changeStylesOfCollectionViewItem(cell)
//                cell.containerView.layer.borderColor = Styles.Colors.filterBorder.color.cgColor
//                cell.containerView.backgroundColor = Styles.Colors.filterBackground.color
//            } else {
//                cell.containerView.layer.borderColor = Styles.Colors.border.color.cgColor
//                cell.containerView.backgroundColor = Styles.Colors.White.normal
//            }
    }
    return cell
  }

  func fetchBookWith(filterType: FilterType) {
    guard let searchString = searchGradientView.searchTextField.text else { return }
    NetworkManagement.getBookSearchWithFilterBy(
      searchString: searchString,
      filterType: filterType
    ) { [weak self] code, data in
      guard let self = self else { return }
      if code == ResponseCode.ok.rawValue {
        self.books = Book.parseData(json: data)
        self.tableView.reloadData()
//                self.collectionView.reloadData()
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

  func changeStylesOfCollectionViewItem(_ cell: FilterCell) {
    if isChoosingRatings || isChoosingPrice {
      cell.containerView.layer.borderColor = Styles.Colors.filterBorder.color.cgColor
      cell.containerView.backgroundColor = Styles.Colors.filterBackground.color
    } else if !isChoosingRatings || !isChoosingPrice {
      cell.containerView.layer.borderColor = Styles.Colors.border.color.cgColor
      cell.containerView.backgroundColor = Styles.Colors.White.normal
    }
  }
}

// MARK: UICollectionViewDelegateFlowLayout

extension BookListViewController: UICollectionViewDelegateFlowLayout {

  // MARK: Internal

  func collectionView(
    _ collectionView: UICollectionView,
    layout _: UICollectionViewLayout,
    sizeForItemAt _: IndexPath
  ) -> CGSize {
    .init(width: 0, height: collectionView.frame.height)
  }

  func collectionView(
    _: UICollectionView,
    layout _: UICollectionViewLayout,
    minimumLineSpacingForSectionAt _: Int
  ) -> CGFloat {
    8
  }

  func collectionView(
    _: UICollectionView, layout _: UICollectionViewLayout,
    insetForSectionAt _: Int
  ) -> UIEdgeInsets {
    .init(top: 0, left: 8, bottom: 0, right: 8)
  }

  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        guard let cell = collectionView.dequeueReusableCell(
//            withReuseIdentifier: "FilterCell",
//            for: indexPath
//        ) as? FilterCell else { return }
    guard let cell = self.collectionView.cellForItem(at: indexPath) as? FilterCell else { return }
    if indexPath.item == 0 {
      isAscending.toggle()
      books = sortByPrice(isAscending: isAscending)
      tableView.reloadData()
      collectionView.reloadData()
    } else if indexPath.item == 2 {
      fetchBookWith(filterType: .price)
      isChoosingPrice = true
      isChoosingRatings = false
      if isChoosingPrice {
        cell.containerView.layer.borderColor = Styles.Colors.filterBorder.color.cgColor
        cell.containerView.backgroundColor = Styles.Colors.filterBackground.color
      } else if !isChoosingPrice {
        cell.containerView.layer.borderColor = Styles.Colors.border.color.cgColor
        cell.containerView.backgroundColor = Styles.Colors.White.normal
      }
    } else if indexPath.item == 3 {
      fetchBookWith(filterType: .ratings)
      isChoosingPrice = false
      isChoosingRatings = true
      if !isChoosingPrice, isChoosingRatings {
        cell.containerView.layer.borderColor = Styles.Colors.filterBorder.color.cgColor
        cell.containerView.backgroundColor = Styles.Colors.filterBackground.color
      } else {
        cell.containerView.layer.borderColor = Styles.Colors.border.color.cgColor
        cell.containerView.backgroundColor = Styles.Colors.White.normal
      }
    }
  }

  // MARK: Private

  private func sortByPrice(isAscending: Bool) -> [Book] {
    let descendingBooks = books.sorted { (book1, book2) -> Bool in
      book1.price > book2.price
    }

    let ascendingBooks = books.sorted { (book1, book2) -> Bool in
      book1.price < book2.price
    }

    return isAscending ? ascendingBooks : descendingBooks
  }
}

// MARK: SearchViewControllerDelegate

extension BookListViewController: SearchViewControllerDelegate {
  func didTappedCancelButton() {
    if searchGradientView.searchTextField.text?.count == 0 && books.count == 0 {
      navigationController?.popViewController(animated: true)
    }
  }

  func didTappedSearchCell(_ books: [Book], searchText: String) {
    searchGradientView.searchTextField.text = searchText
    self.books = books
    tableView.reloadData()
  }
}
