//
//  AlertActionBuilder.swift
//  bsuser
//
//  Created by Khoa Le on 18/10/2020.
//

import UIKit

// MARK: AlertActionBuilder

class AlertActionBuilder {

  // MARK: Lifecycle

  // MARK: Init

  init(_ buildClosure: BuilderClosure) {
    buildClosure(self)
  }

  // MARK: Internal

  typealias BuilderClosure = (AlertActionBuilder) -> Void

  // MARK: Properties

  var rootViewController: UIViewController?
  var title: String?
  var style: UIAlertAction.Style?
}
