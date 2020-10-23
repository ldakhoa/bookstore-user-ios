//
//  BookDetailRecommendationHorizontalController.swift
//  bsuser
//
//  Created by Khoa Le on 23/10/2020.
//

import UIKit

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
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return 11
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

// MARK: - UICollectionViewDelegateFlowLayout

extension BookDetailRecommendHorizontalController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        return .init(width: 170, height: view.frame.height)
    }
}
