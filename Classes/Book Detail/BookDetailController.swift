//
//  BookDetailController.swift
//  bsuser
//
//  Created by Khoa Le on 22/10/2020.
//

import UIKit

final class BookDetailController: UIViewController {

    // MARK: Internal

    let topContainerView = BookDetailTopContainerView()
    let bottomContainerView = BookDetailBottomContainerView()
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupLayout()

        topContainerView.dismissImageView.addGestureRecognizer(UITapGestureRecognizer(
            target: self,
            action: #selector(didTappedDismissImageView)
        ))
        topContainerView.dismissImageView.isUserInteractionEnabled = true

    }

    // MARK: Private

    private func setupLayout() {
        view.backgroundColor = UIColor.white

        view.addSubview(bottomContainerView)
        view.addSubview(topContainerView)

        bottomContainerView.anchor(
            top: nil,
            leading: view.leadingAnchor,
            bottom: view.bottomAnchor,
            trailing: view.trailingAnchor,
            padding: .init(top: 0, left: 0, bottom: 20, right: 0),
            size: .init(width: 0, height: 100)
        )

        topContainerView.anchor(
            top: view.safeAreaLayoutGuide.topAnchor,
            leading: view.leadingAnchor,
            bottom: nil,
            trailing: view.trailingAnchor,
            size: .init(width: 0, height: Styles.Sizes.heightTopView)
        )
    }

    @objc
    private func didTappedDismissImageView() {
        dismiss(animated: true)
    }

}
