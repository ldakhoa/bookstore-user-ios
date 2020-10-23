//
//  HorizontalSnappingController.swift
//  bsuser
//
//  Created by Khoa Le on 23/10/2020.
//

import UIKit

class HorizontalSnappingController: UICollectionViewController {

    // MARK: Lifecycle

    init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Internal

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
    }

}
