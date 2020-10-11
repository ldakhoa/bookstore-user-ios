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

        enum Registration {
            static let signup = registration.instantiateViewController(withIdentifier: "SignUpViewController")
            static let login = registration.instantiateViewController(withIdentifier: "LoginViewController")
        }
    }
    
}
