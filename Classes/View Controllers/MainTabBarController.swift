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

    fetchCart()

    tabBar.tintColor = Styles.Colors.black.color
    tabBarItem.badgeColor = Styles.Colors.Gradient.color3Wo
    let profileNotLoginVC = AppSetting.Storyboards.Profile.notLoginVC
    let cartNotLoginVC = AppSetting.Storyboards.Cart.notLoginVC

    let homeVC = AppSetting.Storyboards.Home.homeVC
    let searchVC = AppSetting.Storyboards.BookList.bookListVC
    let profileVC = AppSecurity.shared.isAuthorized == false ? profileNotLoginVC : ProfileTableViewController()
    let categoryVC = AppSetting.Storyboards.Category.categoryVC
    let cartVC = AppSecurity.shared.isAuthorized == false ? cartNotLoginVC : AppSetting.Storyboards.Cart.cartVC

    viewControllers = [
      createNavController(
        viewController: homeVC,
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

  func repositionBadge() {
    for badgeView in tabBar.subviews[3].subviews {
      if NSStringFromClass(badgeView.classForCoder) == "_UIBadgeView" {
        badgeView.layer.transform = CATransform3DIdentity
        badgeView.layer.transform = CATransform3DMakeTranslation(-4.5, -1.0, -1)
      }
    }
  }

  // MARK: Private

  private var cartInfo: CartInfo?

  private func fetchCart() {
    NetworkManagement.getCartInfoByUser(id: AppSecurity.shared.userID) { code, data in
      if code == ResponseCode.ok.rawValue {
        self.cartInfo = CartInfo.parseData(json: data)
        if let tabItems = self.tabBar.items {
          let tabItem = tabItems[2]
          if self.cartInfo?.booksQuantity ?? 0 <= 0 {
            tabItem.badgeValue = nil
          } else {
            tabItem.badgeValue = "\(self.cartInfo?.booksQuantity ?? 0)"
            self.repositionBadge()
          }
        }
      } else {
        let errMessage = data["message"].stringValue
        let alert = UIAlertController.configured(
          title: "Something wrong",
          message: errMessage,
          preferredStyle: .alert
        )
        alert.addAction(AlertAction.ok())
        self.present(alert, animated: true)
      }
    }
  }

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
