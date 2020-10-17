//
//  AppSecurity.swift
//  bsuser
//
//  Created by Khoa Le on 17/10/2020.
//

import Foundation

final class AppSecurity {
    private let defaults = UserDefaults.standard
    static let shared = AppSecurity()

    enum Keys: String {
        case email
        case userID
        case isAuthorized
        case userInforExist
    }

    var userID: String! {
        get {
            return defaults.object(forKey: Keys.userID.rawValue) == nil ? "" : (defaults.object(forKey: Keys.userID.rawValue) as? String)!
        } set {
            defaults.set(newValue, forKey: Keys.userID.rawValue)
        }
    }

    var email: String! {
        get {
            return defaults.object(forKey: Keys.email.rawValue) == nil ? "" : (defaults.object(forKey: Keys.email.rawValue) as? String)!
        } set {
            defaults.set(newValue, forKey: Keys.email.rawValue)
        }
    }

    var isAuthorized: Bool {
        get {
            return defaults.object(forKey: Keys.isAuthorized.rawValue) == nil ? false : (defaults.object(forKey: Keys.isAuthorized.rawValue) as? Bool)!
        } set {
            defaults.set(newValue, forKey: Keys.isAuthorized.rawValue)
        }
    }

    var userInforExist: Bool {
        get {
            return defaults.object(forKey: Keys.userInforExist.rawValue) == nil ? false : (defaults.object(forKey: Keys.userInforExist.rawValue) as? Bool)!
        } set {
            defaults.set(newValue, forKey: Keys.userInforExist.rawValue)
        }
    }

}
