//
//  AppDelegate.swift
//  bsuser
//
//  Created by Khoa Le on 10/10/2020.
//

import IQKeyboardManagerSwift
import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
  var window: UIWindow?

  func application(
    _: UIApplication,
    didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    IQKeyboardManager.shared.enable = true

    return true
  }
}
