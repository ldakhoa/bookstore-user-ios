//
//  AppDelegate.swift
//  bsuser
//
//  Created by Khoa Le on 10/10/2020.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {

        // TODO: - Turn off this when implement cart/checkout feature
        AppSetting.shared.checkMainScreen()
        return true
    }
}
