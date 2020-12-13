//
//  InteractivePopRecognizer.swift
//  bsuser
//
//  Created by Khoa Le on 13/12/2020.
//

import UIKit

final class InteractivePopRecognizer: NSObject, UIGestureRecognizerDelegate {

  // MARK: Lifecycle

  init(controller: UINavigationController) {
    navigationController = controller
  }

  // MARK: Internal

  var navigationController: UINavigationController

  func gestureRecognizerShouldBegin(_: UIGestureRecognizer) -> Bool {
    navigationController.viewControllers.count > 1
  }

  // This is necessary because without it, subviews of your top controller can
  // cancel out your gesture recognizer on the edge.
  func gestureRecognizer(
    _: UIGestureRecognizer,
    shouldRecognizeSimultaneouslyWith _: UIGestureRecognizer
  ) -> Bool {
    true
  }

}
