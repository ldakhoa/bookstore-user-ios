//
//  AppSetting.swift
//  bsuser
//
//  Created by Khoa Le on 11/10/2020.
//

import UIKit

struct AppSetting {
    static let shared = AppSetting()

    static let appDelegate = UIApplication.shared.delegate as! AppDelegate
    enum Storyboards {
        static let registration = UIStoryboard(name: "Registration", bundle: nil)
        static let home = UIStoryboard(name: "Home", bundle: nil)
        static let category = UIStoryboard(name: "Category", bundle: nil)
        static let bookList = UIStoryboard(name: "BookList", bundle: nil)

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

        enum Search {
            static let bookListVC = bookList.instantiateViewController(withIdentifier: "BookListViewController")
        }
    }
}
