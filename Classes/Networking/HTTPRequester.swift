//
//  HTTPRequester.swift
//  bsuser
//
//  Created by Khoa Le on 13/10/2020.
//

import Alamofire
import Foundation

//let coreURL = "http://localhost:8000/"
let coreURL = "http://192.168.1.3:8000/"

// MARK: - Requestable

protocol Requestable {
  func params() -> (
    path: URL,
    method: Alamofire.HTTPMethod,
    parameter: Parameters?,
    encoding: ParameterEncoding
  )
}

// MARK: - HTTPRequester

enum HTTPRequester {
  case login(email: String, password: String)
  case signup(username: String, email: String, password: String)
  case getInformationOfUserWith(id: Int)
  case updateInformationOfUserWith(id: Int)
  case getBookSearchBy(searchString: String)
  case getBookSearchWithFilterBy(searchString: String, filterType: FilterType)
}

// MARK: Requestable

extension HTTPRequester: Requestable {
  func params() -> (
    path: URL,
    method: HTTPMethod,
    parameter: Parameters?,
    encoding: ParameterEncoding
  ) {
    switch self {
    case let .login(email, password):
      let params: [String: String] = ["email": email, "password": password]
      return (
        path: URL(string: coreURL + "api/users/login")!,
        method: .post,
        parameter: params,
        encoding: JSONEncoding.default
      )
    case let .signup(username, email, password):
      let params: [String: String] = [
        "username": username,
        "email": email,
        "password": password,
      ]
      return (
        path: URL(string: coreURL + "api/users/login")!,
        method: .post,
        parameter: params,
        encoding: JSONEncoding.default
      )
    case let .getInformationOfUserWith(id):
      return (
        path: URL(string: coreURL + "api/users/\(id)")!,
        method: .get,
        parameter: nil,
        encoding: JSONEncoding.default
      )
    case let .updateInformationOfUserWith(id):
      let params: [String: Int] = ["id": id]
      return (
        path: URL(string: coreURL + "api/users/\(id)")!,
        method: .put,
        parameter: params,
        encoding: JSONEncoding.default
      )
    case let .getBookSearchBy(searchString):
      return (
        path: URL(string: coreURL + "api/books/?search=\(searchString)")!,
        method: .get,
        parameter: nil,
        encoding: JSONEncoding.default
      )
    case let .getBookSearchWithFilterBy(searchString, filter):
      return (
        path: URL(string: coreURL + "api/books/?search=\(searchString)&filter=\(filter)&limit=20")!,
        method: .get,
        parameter: nil,
        encoding: JSONEncoding.default
      )
    }
  }
}
