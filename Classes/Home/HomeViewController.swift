//
//  HomeViewController.swift
//  bsuser
//
//  Created by Khoa Le on 11/10/2020.
//

import UIKit

final class HomeViewController: UIViewController {

    // MARK: Internal

    @IBOutlet var searchGradientView: SearchGradientView!

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = Styles.Colors.background.color
    }

    // MARK: Private

    @objc
    private func handleReturnUIState() {
        searchGradientView.searchTextField.resignFirstResponder()
        searchGradientView.searchTextField.text = ""
    }
}
