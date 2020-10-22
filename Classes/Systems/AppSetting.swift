//
//  AppSetting.swift
//  bsuser
//
//  Created by Khoa Le on 11/10/2020.
//

import UIKit

struct AppSetting {
    enum Storyboards {
        enum Registration {
            static let signup = registration.instantiateViewController(withIdentifier: "SignUpViewController")
            static let login = registration.instantiateViewController(withIdentifier: "LoginViewController")
        }

        enum Home {
            static let homeVC = home.instantiateViewController(withIdentifier: "HomeViewController")
        }

        enum Category {
            static let categoryVC = category.instantiateViewController(withIdentifier: "CategoryViewController")
        }

        enum BookList {
            static let bookListVC = bookList.instantiateViewController(withIdentifier: "BookListViewController")
        }

        enum Search {
            static let searchVC = search.instantiateViewController(withIdentifier: "SearchViewController")
        }

        static let registration = UIStoryboard(name: "Registration", bundle: nil)
        static let home = UIStoryboard(name: "Home", bundle: nil)
        static let category = UIStoryboard(name: "Category", bundle: nil)
        static let bookList = UIStoryboard(name: "BookList", bundle: nil)
        static let search = UIStoryboard(name: "Search", bundle: nil)

    }

    static let shared = AppSetting()

    static let appDelegate = UIApplication.shared.delegate as? AppDelegate

    func getLoginController() {
        AppSetting.appDelegate?.window?.rootViewController = AppSetting.Storyboards.Registration.login
    }

    func getMainController() {
        let mainTabBarController = MainTabBarController()
        AppSetting.appDelegate?.window?.rootViewController = mainTabBarController
        AppSetting.appDelegate?.window?.makeKeyAndVisible()
    }

    func checkMainScreen() {
        AppSecurity.shared.isAuthorized == true ? AppSetting.shared.getMainController(): AppSetting.shared.getLoginController()
    }

    func logout() {
        AppSecurity.shared.userID = -1
        AppSecurity.shared.isAuthorized = false
        AppSecurity.shared.isUserInfoExist = false
    }
}
