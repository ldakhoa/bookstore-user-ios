//
//  AlertAction.swift
//  bsuser
//
//  Created by Khoa Le on 18/10/2020.
//

import UIKit

typealias AlertActionBlock = (UIAlertAction) -> Void

// MARK: - AlertAction

struct AlertAction {

    // MARK: Lifecycle

    // MARK: Init

    init(_ builder: AlertActionBuilder) {
        rootViewController = builder.rootViewController
        title = builder.title
        style = builder.style ?? .default
    }

    // MARK: Internal

    let rootViewController: UIViewController?
    let title: String?
    let style: UIAlertAction.Style

    // MARK: Static

    static func cancel(_ handler: AlertActionBlock? = nil) -> UIAlertAction {
        UIAlertAction(title: "Cancel", style: .cancel, handler: handler)
    }

    static func ok(_ handler: AlertActionBlock? = nil) -> UIAlertAction {
        UIAlertAction(title: "OK", style: .default, handler: handler)
    }

    static func no(_ handler: AlertActionBlock? = nil) -> UIAlertAction {
        UIAlertAction(title: "No", style: .destructive, handler: handler)
    }

    static func yes(_ handler: AlertActionBlock? = nil) -> UIAlertAction {
        UIAlertAction(title: "Yes", style: .default, handler: handler)
    }

    static func tryAgain(_ handler: AlertActionBlock? = nil) -> UIAlertAction {
        UIAlertAction(title: "Try again", style: .default, handler: handler)
    }

    func get(_ handler: AlertActionBlock? = nil) -> UIAlertAction {
        UIAlertAction(title: title, style: style, handler: handler)
    }
}
