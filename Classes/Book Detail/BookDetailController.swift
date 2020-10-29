//
//  BookDetailController.swift
//  bsuser
//
//  Created by Khoa Le on 22/10/2020.
//

import UIKit

final class BookDetailController: UIViewController {

    // MARK: Internal

    var book: Book?
    let cellsID: [String] = [
        "BookDetailMainCell",
        "BookDetailDescriptionCell",
        "BookDetailRecommendationCell",
    ]
    let topContainerView = BookDetailTopContainerView()
    let bottomContainerView = BookDetailBottomContainerView()

    var contentOffsetYAfter: CGFloat = 0

    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(
            UINib(nibName: cellsID[0], bundle: nil),
            forCellReuseIdentifier: cellsID[0]
        )
        tableView.register(
            UINib(nibName: cellsID[1], bundle: nil),
            forCellReuseIdentifier: cellsID[1]
        )
        tableView.register(BookDetailRecommendationCell.self, forCellReuseIdentifier: cellsID[2])
        tableView.register(BookDetailRecommendationCell.self, forCellReuseIdentifier: "cellID")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorInset = .init(top: 0, left: 16, bottom: 0, right: 16)
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupLayout()

        topContainerView.dismissView.addGestureRecognizer(UITapGestureRecognizer(
            target: self,
            action: #selector(didTappedDismissImageView)
        ))
        topContainerView.dismissView.isUserInteractionEnabled = true
        isEnabledShadowForTopView(opacity: 0.25)

    }

    // MARK: Private

    private func setupLayout() {
        view.backgroundColor = UIColor.white

        view.addSubview(bottomContainerView)
        view.addSubview(tableView)
        view.addSubview(topContainerView)

        bottomContainerView.anchor(
            top: nil,
            leading: view.leadingAnchor,
            bottom: view.bottomAnchor,
            trailing: view.trailingAnchor,
            padding: .init(top: 0, left: 0, bottom: 20, right: 0),
            size: .init(width: 0, height: 90)
        )

        topContainerView.anchor(
            top: view.safeAreaLayoutGuide.topAnchor,
            leading: view.leadingAnchor,
            bottom: nil,
            trailing: view.trailingAnchor,
            size: .init(width: 0, height: Styles.Sizes.heightTopView)
        )

        tableView.anchor(
            top: view.safeAreaLayoutGuide.topAnchor,
            leading: view.leadingAnchor,
            bottom: bottomContainerView.topAnchor,
            trailing: view.trailingAnchor
        )
    }

    @objc
    private func didTappedDismissImageView() {
        dismiss(animated: true)
    }

}

extension BookDetailController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return cellsID.count + 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: cellsID[0],
                for: indexPath
            ) as? BookDetailMainCell else { return UITableViewCell() }
            cell.book = book
            cell.selectionStyle = .none
            return cell
        } else if indexPath.section == 1 {
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: cellsID[1],
                for: indexPath
            ) as? BookDetailDescriptionCell else { return UITableViewCell() }
            cell.selectionStyle = .none
            return cell
        } else if indexPath.section == 2 {
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: cellsID[2],
                for: indexPath
            ) as? BookDetailRecommendationCell else { return UITableViewCell() }
            cell.selectionStyle = .none
            return cell
        } else if indexPath.section == 3 {
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: "cellID",
                for: indexPath
            ) as? BookDetailRecommendationCell else { return UITableViewCell() }
            cell.titleLabel.text = "Customers who bought this item also bought"
            cell.selectionStyle = .none
            return cell
        }
        return UITableViewCell()
    }
}

extension BookDetailController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 2 {
            return 370
        } else if indexPath.section == 3 {
            return 360
        }
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 460
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y > 50 {
            let alpha = scrollView.contentOffset.y / 230
            let opacityRemainder = 0.25 - scrollView.contentOffset.y / 1000
            isEnabledShadowForTopView(opacity: Float(opacityRemainder))
            topContainerView.backgroundColor = Styles.Colors.White.normal.withAlphaComponent(alpha)
            if contentOffsetYAfter > 0 && scrollView.contentOffset.y > 200 {
                topContainerView.bottomLayer.backgroundColor = Styles.Colors.separate.color.withAlphaComponent(alpha).cgColor
                contentOffsetYAfter = scrollView.contentOffset.y
            } else if scrollView.contentOffset.y - contentOffsetYAfter < 0 && scrollView.contentOffset.y < 200 {
                topContainerView.bottomLayer.backgroundColor = Styles.Colors.separate.color.withAlphaComponent(0).cgColor
            }
            contentOffsetYAfter = scrollView.contentOffset.y
        } else {
            topContainerView.backgroundColor = Styles.Colors.White.normal.withAlphaComponent(0)
        }
    }

    private func isEnabledShadowForTopView(opacity: Float) {
        topContainerView.dismissView.toTopViewShadow(opacity: opacity)
        topContainerView.favoriteView.toTopViewShadow(opacity: opacity)
        topContainerView.cartView.toTopViewShadow(opacity: opacity)
    }
}
