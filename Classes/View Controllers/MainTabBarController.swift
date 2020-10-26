//
//  MainTabBarController.swift
//  bsuser
//
//  Created by Khoa Le on 11/10/2020.
//

import UIKit

final class MainTabBarController: UITabBarController {

    // MARK: Internal

    override func viewDidLoad() {
        super.viewDidLoad()

        tabBar.tintColor = Styles.Colors.black.color

        let homeVC = AppSetting.Storyboards.Home.homeVC
        let searchVC = AppSetting.Storyboards.BookList.bookListVC
        let profileVC = ProfileTableViewController()
        let categoryVC = AppSetting.Storyboards.Category.categoryVC
        let cartVC = AppSetting.Storyboards.Cart.cartVC

        viewControllers = [
            createNavController(
                viewController: searchVC,
                title: "Shop",
                imageName: "home-inactive",
                selectedImageName: "home-activated"
            ),
            createNavController(
                viewController: categoryVC,
                title: "Category",
                imageName: "category-inactive",
                selectedImageName: "category-activated"
            ),
            createNavController(
                viewController: cartVC,
                title: "Cart",
                imageName: "bag-inactive",
                selectedImageName: "bag-activated"
            ),
            createNavController(
                viewController: profileVC,
                title: "Profile",
                imageName: "profile-inactive",
                selectedImageName: "profile-activated"
            ),
        ]
    }

    // MARK: Private

    private func createNavController(
        viewController: UIViewController,
        title: String,
        imageName: String,
        selectedImageName: String
    ) -> UIViewController {
        let navController = UINavigationController(rootViewController: viewController)
        navController.navigationBar.prefersLargeTitles = true

        navController.tabBarItem.title = title
        navController.tabBarItem.selectedImage = UIImage(named: selectedImageName)
        navController.tabBarItem.image = UIImage(named: imageName)

        viewController.view.backgroundColor = .white

        navController.setNavigationBarHidden(true, animated: true)

        return navController
    }
}
