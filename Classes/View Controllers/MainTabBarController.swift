//
//  MainTabBarController.swift
//  bsuser
//
//  Created by Khoa Le on 11/10/2020.
//

import BATabBarController
import UIKit

final class MainTabBarController: UIViewController, BATabBarControllerDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        let baTabBarController = BATabBarController()

        let homeTabbarItem = BATabBarItem(
            image: UIImage(named: "home-inactive")!,
            selectedImage: UIImage(named: "home-activated")!
        )
        let categoryTabbarItem = BATabBarItem(
            image: UIImage(named: "category-inactive")!,
            selectedImage: UIImage(named: "category-activated")!
        )
        let bagTabbarItem = BATabBarItem(
            image: UIImage(named: "bag-inactive")!,
            selectedImage: UIImage(named: "bag-activated")!
        )
        let profileTabbarItem = BATabBarItem(
            image: UIImage(named: "profile-inactive")!,
            selectedImage: UIImage(named: "profile-activated")!
        )

        baTabBarController.tabBarItems = [
            homeTabbarItem,
            categoryTabbarItem,
            bagTabbarItem,
            profileTabbarItem,
        ]

        let homeVC = AppSetting.Storyboards.Home.homeVC
        let searchVC = AppSetting.Storyboards.Search.bookListVC
        let profileVC = ProfileTableViewController()
        let profileNavbarVC = UINavigationController(rootViewController: profileVC)

        let categoryVC = AppSetting.Storyboards.Category.categoryVC

        let vc4 = UIViewController()
        vc4.view.backgroundColor = .yellow

        baTabBarController.delegate = self
        // TODO: - Change order of tabbar
        baTabBarController.viewControllers = [searchVC, categoryVC, homeVC, profileNavbarVC]
        baTabBarController.tabBarBackgroundColor = Styles.Colors.white
        baTabBarController.tabBarItemStrokeColor = Styles.Colors.primary.color
        baTabBarController.tabBarAnimationDuration = 0.5
        view.addSubview(baTabBarController.view)
    }

    func tabBarController(_: BATabBarController, didSelect _: UIViewController) {}
}
