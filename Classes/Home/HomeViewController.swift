//
//  HomeViewController.swift
//  bsuser
//
//  Created by Khoa Le on 11/10/2020.
//

import UIKit

final class HomeViewController: UIViewController {

    @IBOutlet weak var searchGradientView: SearchGradientView! {
        didSet {
            searchGradientView.backButton.addTarget(self, action: #selector(handleReturnUIState), for: .touchUpInside)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = Styles.Colors.background.color
    }

    @objc private func handleReturnUIState() {
        searchGradientView.setTextFieldWithoutBack()
        searchGradientView.searchTextField.resignFirstResponder()
        searchGradientView.searchTextField.text = ""
    }
}
