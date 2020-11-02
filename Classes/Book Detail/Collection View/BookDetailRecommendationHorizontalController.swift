//
//  BookDetailRecommendationHorizontalController.swift
//  bsuser
//
//  Created by Khoa Le on 23/10/2020.
//

import UIKit

// MARK: - BookDetailRecommendHorizontalController

final class BookDetailRecommendHorizontalController: HorizontalSnappingController {
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(
            UINib(nibName: "BookDetailRecommendCollectionCell", bundle: nil),
            forCellWithReuseIdentifier: "BookDetailRecommendCollectionCell"
        )
        collectionView.showsHorizontalScrollIndicator = false
        if let layout = collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
        }
    }

    override func collectionView(
        _: UICollectionView,
        numberOfItemsInSection _: Int
    ) -> Int {
        11
    }

    override func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "BookDetailRecommendCollectionCell",
            for: indexPath
        ) as? BookDetailRecommendCollectionCell else { return UICollectionViewCell() }
        return cell
    }
}

// MARK: UICollectionViewDelegateFlowLayout

extension BookDetailRecommendHorizontalController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _: UICollectionView,
        layout _: UICollectionViewLayout,
        sizeForItemAt _: IndexPath
    ) -> CGSize {
        .init(width: 170, height: view.frame.height)
    }
}
