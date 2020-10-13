//
//  SearchViewController.swift
//  bsuser
//
//  Created by Khoa Le on 12/10/2020.
//

import UIKit

final class SearchViewController: UIViewController {
    @IBOutlet var tableView: UITableView!
    @IBOutlet var collectionView: UICollectionView!

    let filterDatasource: [String] = [
        "Sorted by: Ascending",
        "Category",
        "Price",
        "Rating",
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.backgroundColor = Styles.Colors.background.color
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self

        collectionView.dataSource = self
        collectionView.delegate = self

    }
}

extension SearchViewController: UITableViewDataSource {
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return 10
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchCell", for: indexPath) as! SearchCell
        return cell
    }
}

extension SearchViewController: UITableViewDelegate {
    func tableView(_: UITableView, heightForRowAt _: IndexPath) -> CGFloat {
        return 135 + 16 + 16
    }
}

extension SearchViewController: UICollectionViewDataSource {
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

extension SearchViewController: UICollectionViewDelegateFlowLayout {
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
