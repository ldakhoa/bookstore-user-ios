//
//  SearchViewController.swift
//  bsuser
//
//  Created by Khoa Le on 19/10/2020.
//

import UIKit

// MARK: - SearchViewControllerDelegate

protocol SearchViewControllerDelegate: AnyObject {
  func didTappedSearchCell(_ books: [Book], searchText: String)
  func didTappedCancelButton()
}

// MARK: - SearchViewController

final class SearchViewController: UIViewController {

  // MARK: Internal

  @IBOutlet var searchGradientView: SearchGradientView!
  @IBOutlet var tableView: UITableView!
  var timer: Timer?
  var books = [Book]()

  weak var delegate: SearchViewControllerDelegate?

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
    dismiss(animated: true) {
      self.delegate?.didTappedCancelButton()
    }
  }

  @objc
  private func textEditingChanged(textField: UITextField) {
    guard let textString = textField.text else { return }
    let searchText = textString.replacingOccurrences(of: " ", with: "%20", options: .literal)
    timer?.invalidate()
    timer = Timer.scheduledTimer(withTimeInterval: 0.6, repeats: false, block: { _ in
      if textString.count == 0 {
        self.books.removeAll()
        self.tableView.reloadData()
      } else {
        self.getBookBySearch(text: searchText)
      }
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

// MARK: UITableViewDataSource

extension SearchViewController: UITableViewDataSource {
  func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
    books.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "SearchCell", for: indexPath) as? SearchCell else { return UITableViewCell() }
    cell.bookNameLabel.text = books[indexPath.row].title
    return cell
  }
}

// MARK: UITableViewDelegate

extension SearchViewController: UITableViewDelegate {
  func tableView(_: UITableView, heightForRowAt _: IndexPath) -> CGFloat {
    44
  }

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: false)
    dismiss(animated: true) { [weak self] in
      guard let self = self else { return }
      self.delegate?.didTappedSearchCell(
        self.books,
        searchText: self.searchGradientView.searchTextField.text ?? ""
      )
      self.didTappedRightImageView()
    }
  }
}
