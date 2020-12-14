//
//  HomeViewController.swift
//  bsuser
//
//  Created by Khoa Le on 11/10/2020.
//

import UIKit

final class HomeViewController: UIViewController {

  // MARK: Internal

  @IBOutlet var searchGradientView: SearchGradientView! {
    didSet {
      searchGradientView.searchTextField.isUserInteractionEnabled = false
      searchGradientView.layoutForOtherViewController()
    }
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    view.backgroundColor = Styles.Colors.background.color
    searchGradientView.addGestureRecognizer(UITapGestureRecognizer(
      target: self,
      action: #selector(didTappedSearchGradientView)
    ))
  }

  // MARK: Private

  @objc
  private func didTappedSearchGradientView() {
    guard let bookListVC = AppSetting.Storyboards.BookList.bookListVC as? BookListViewController else { return }
    bookListVC.shouldPresentSearchController = true

    //		searchVC.delegate = self
    navigationController?.pushViewController(bookListVC, animated: true)
  }

}
