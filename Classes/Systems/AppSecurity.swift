//
//  AppSecurity.swift
//  bsuser
//
//  Created by Khoa Le on 17/10/2020.
//

import Foundation

final class AppSecurity {

  // MARK: Internal

  enum Keys: String {
    case email
    case userID
    case isAuthorized
    case isUserInfoExist
    case token
  }

  static let shared = AppSecurity()

  var userID: Int! {
    get {
      defaults.object(forKey: Keys.userID.rawValue) == nil ? -1 : (defaults.object(forKey: Keys.userID.rawValue) as? Int)!
    } set {
      defaults.set(newValue, forKey: Keys.userID.rawValue)
    }
  }

  var email: String! {
    get {
      defaults.object(forKey: Keys.email.rawValue) == nil ? "" : (defaults.object(forKey: Keys.email.rawValue) as? String)!
    } set {
      defaults.set(newValue, forKey: Keys.email.rawValue)
    }
  }

  var isAuthorized: Bool {
    get {
      defaults.object(forKey: Keys.isAuthorized.rawValue) == nil ? false : (defaults.object(forKey: Keys.isAuthorized.rawValue) as? Bool)!
    } set {
      defaults.set(newValue, forKey: Keys.isAuthorized.rawValue)
    }
  }

  var token: String! {
    get {
      defaults.object(forKey: Keys.token.rawValue) == nil ? "" : (defaults.object(forKey: Keys.token.rawValue) as? String)!
    } set {
      defaults.set(newValue, forKey: Keys.token.rawValue)
    }
  }

  var isUserInfoExist: Bool {
    get {
      defaults.object(forKey: Keys.isUserInfoExist.rawValue) == nil ? false : (defaults.object(forKey: Keys.isUserInfoExist.rawValue) as? Bool)!
    } set {
      defaults.set(newValue, forKey: Keys.isUserInfoExist.rawValue)
    }
  }

  // MARK: Private

  private let defaults = UserDefaults.standard
}
