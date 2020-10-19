//
//  SearchViewController.swift
//  bsuser
//
//  Created by Khoa Le on 12/10/2020.
//

import UIKit

final class BookListViewController: UIViewController {

    // MARK: Internal

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
            searchGradientView.layoutForOtherViewController()
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

        searchGradientView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTappedSearchGradientView)))
    }

    // MARK: Private

    @objc private func didTappedSearchGradientView() {
        let searchVC = AppSetting.Storyboards.Search.searchVC
        searchVC.modalPresentationStyle = .fullScreen
        present(searchVC, animated: true)
    }
}

extension BookListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection _: Int) -> Int {
        return 10
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "BookListCell",
            for: indexPath
        ) as! BookListCell
        return cell
    }
}

extension BookListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt _: IndexPath) -> CGFloat {
        return 135 + 16 + 16
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
