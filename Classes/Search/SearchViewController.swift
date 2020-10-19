//
//  SearchViewController.swift
//  bsuser
//
//  Created by Khoa Le on 19/10/2020.
//

import UIKit

final class SearchViewController: UIViewController {

    // MARK: Internal

    @IBOutlet weak var searchGradientView: SearchGradientView!
    @IBOutlet weak var tableView: UITableView!
    var timer: Timer?
    var books = [Book]()

    override func viewDidLoad() {
        super.viewDidLoad()

        searchGradientView.layoutForSearchController()
        searchGradientView.cancelButton.addTarget(
            self,
            action: #selector(didTappedCancelButton),
            for: .touchUpInside
        )
        searchGradientView.searchTextField.addTarget(
            self,
            action: #selector(textEditingChanged),
            for: .editingChanged
        )

        searchGradientView.searchTextField.rightImageView.addGestureRecognizer(UITapGestureRecognizer(
            target: self,
            action: #selector(didTappedRightImageView)
        ))
        searchGradientView.searchTextField.rightImageView.isUserInteractionEnabled = true

        tableView.dataSource = self
        tableView.delegate = self
        tableView.keyboardDismissMode = .onDrag
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        searchGradientView.searchTextField.becomeFirstResponder()
    }

    // MARK: Private

    @objc
    private func didTappedRightImageView() {
        searchGradientView.searchTextField.text = ""
        books.removeAll()
        tableView.reloadData()
    }

    @objc
    private func didTappedCancelButton() {
        dismiss(animated: true)
    }

    @objc
    private func textEditingChanged(textField: UITextField) {
        guard let textString = textField.text, !textString.isEmpty else { return }
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.6, repeats: false, block: { _ in
            self.getBookBySearch(text: textString)
        })

    }

    private func getBookBySearch(text: String) {
        NetworkManagement.getBookSearchBy(searchString: text) { [weak self] code, data in
            guard let self = self else { return }
            if code == ResponseCode.ok.rawValue {
                self.books = Book.parseData(json: data)
                self.tableView.reloadData()
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
}

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchCell", for: indexPath) as! SearchCell
        cell.bookNameLabel.text = books[indexPath.row].title
        return cell
    }
}

extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
}
