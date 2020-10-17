//
//  AlertActionBuilder.swift
//  bsuser
//
//  Created by Khoa Le on 18/10/2020.
//

import UIKit

// MARK: AlertActionBuilder

class AlertActionBuilder {
    typealias BuilderClosure = (AlertActionBuilder) -> Void

    // MARK: Properties

    var rootViewController: UIViewController?
    var title: String?
    var style: UIAlertAction.Style?

    // MARK: Init

    init(_ buildClosure: BuilderClosure) {
        buildClosure(self)
    }
}

