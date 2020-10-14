//
//  SearchViewController.swift
//  bsuser
//
//  Created by Khoa Le on 12/10/2020.
//

import UIKit

final class BookListViewController: UIViewController {

    // MARK: Internal

    @IBOutlet var bookListTableView: UITableView!
    @IBOutlet var searchTableView: UITableView!
    @IBOutlet var collectionView: UICollectionView!
    let filterDatasource: [String] = [
        "Sorted by: Ascending",
        "Category",
        "Price",
        "Rating",
    ]

    @IBOutlet var searchGradientView: SearchGradientView! {
        didSet {
            searchGradientView.searchTextField.addTarget(
                self,
                action: #selector(didTappedToSearchTextField),
                for: .editingDidBegin
            )
            searchGradientView.backButton.addTarget(
                self,
                action: #selector(didTapBackButton),
                for: .touchUpInside
            )
        }
    }

    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        bookListTableView.backgroundColor = Styles.Colors.background.color
        bookListTableView.separatorStyle = .none
        bookListTableView.delegate = self
        bookListTableView.dataSource = self

        searchTableView.backgroundColor = Styles.Colors.background2.color
        searchTableView.separatorStyle = .none
        searchTableView.delegate = self
        searchTableView.dataSource = self

        collectionView.dataSource = self
        collectionView.delegate = self
    }

    // MARK: Private

    @objc
    private func didTappedToSearchTextField() {
        bookListTableView.isHidden = true
        searchTableView.isHidden = false
    }

    @objc
    private func didTapBackButton() {
        bookListTableView.isHidden = false
        searchTableView.isHidden = true
        searchGradientView.setTextFieldWithoutBack()
        searchGradientView.searchTextField.resignFirstResponder()
    }
}

extension BookListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection _: Int) -> Int {
        if tableView == bookListTableView {
            return 10
        } else {
            return 8
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == bookListTableView {
            let cell = tableView.dequeueReusableCell(
                withIdentifier: "BookListCell",
                for: indexPath
            ) as! BookListCell
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(
                withIdentifier: "BookSearchCell",
                for: indexPath
            )
            return cell
        }
    }
}

extension BookListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt _: IndexPath) -> CGFloat {
        if tableView == bookListTableView {
            return 135 + 16 + 16
        } else {
            return 40
        }
    }
}

extension BookListViewController: UICollectionViewDataSource {
    func numberOfSections(in _: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_: UICollectionView, numberOfItemsInSection _: Int) -> Int {
        return filterDatasource.count
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "FilterCell",
            for: indexPath
        ) as! FilterCell
        cell.textLabel.text = filterDatasource[indexPath.item]
        if indexPath.item == 0 {
            cell.iconImageView.image = #imageLiteral(resourceName: "swap")
        } else if indexPath.item == 1 {
            cell.iconImageView.image = #imageLiteral(resourceName: "down-arrow")
        }
        return cell
    }
}

extension BookListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout _: UICollectionViewLayout,
        sizeForItemAt _: IndexPath
    ) -> CGSize {
        return .init(width: 0, height: collectionView.frame.height)
    }

    func collectionView(
        _: UICollectionView,
        layout _: UICollectionViewLayout,
        minimumLineSpacingForSectionAt _: Int
    ) -> CGFloat {
        return 8
    }

    func collectionView(
        _: UICollectionView, layout _: UICollectionViewLayout,
        insetForSectionAt _: Int
    ) -> UIEdgeInsets {
        return .init(top: 0, left: 8, bottom: 0, right: 8)
    }
}
