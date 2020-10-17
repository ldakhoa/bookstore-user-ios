//
//  AlertAction.swift
//  bsuser
//
//  Created by Khoa Le on 18/10/2020.
//

import UIKit

typealias AlertActionBlock = (UIAlertAction) -> Void

struct AlertAction {
    let rootViewController: UIViewController?
    let title: String?
    let style: UIAlertAction.Style

    // MARK: Init

    init(_ builder: AlertActionBuilder) {
        rootViewController = builder.rootViewController
        title = builder.title
        style = builder.style ?? .default
    }

    // MARK: Public

    func get(_ handler: AlertActionBlock? = nil) -> UIAlertAction {
        return UIAlertAction(title: title, style: style, handler: handler)
    }

    // MARK: Static

    static func cancel(_ handler: AlertActionBlock? = nil) -> UIAlertAction {
        return UIAlertAction(title: "Cancel", style: .cancel, handler: handler)
    }

    static func ok(_ handler: AlertActionBlock? = nil) -> UIAlertAction {
        return UIAlertAction(title: "OK", style: .default, handler: handler)
    }

    static func no(_ handler: AlertActionBlock? = nil) -> UIAlertAction {
        return UIAlertAction(title: "No", style: .destructive, handler: handler)
    }

    static func yes(_ handler: AlertActionBlock? = nil) -> UIAlertAction {
        return UIAlertAction(title: "Yes", style: .default, handler: handler)
    }

    static func tryAgain(_ handler: AlertActionBlock? = nil) -> UIAlertAction {
        return UIAlertAction(title: "Try again", style: .default, handler: handler)
    }
}

