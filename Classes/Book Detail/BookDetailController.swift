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

    let topContainerView = BookDetailTopContainerView()
    let bottomContainerView = BookDetailBottomContainerView()
    lazy var tableView: UITableView = {
        let tableView = UITableView()

        let nib = UINib(nibName: "BookDetailMainCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "BookDetailMainCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorInset = .init(top: 0, left: 16, bottom: 0, right: 16)
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
        view.addSubview(tableView)

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

        tableView.anchor(top: topContainerView.bottomAnchor, leading: view.leadingAnchor, bottom: bottomContainerView.topAnchor, trailing: view.trailingAnchor)
    }

    @objc
    private func didTappedDismissImageView() {
        dismiss(animated: true)
    }

}

extension BookDetailController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "BookDetailMainCell", for: indexPath) as? BookDetailMainCell else { return UITableViewCell() }
            cell.book = self.book

            return cell
        }
        return UITableViewCell()
    }
}

extension BookDetailController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return UITableView.automaticDimension
        }
        return 460
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 460
        }
        return 0
    }
}
