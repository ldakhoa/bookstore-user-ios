//
//  HTTPRequester.swift
//  bsuser
//
//  Created by Khoa Le on 13/10/2020.
//

import Alamofire
import Foundation

let coreURL = "http://localhost:3000/"

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
  case getCartByUser(id: Int)
  case postCartByUser(id: Int, bookId: Int)
  case getCartInfoByUser(id: Int)
  case postPaymentOrderByUser(id: Int)
  case putQuantityOfBookByUser(id: Int, bookId: Int, quantity: Int)
  case getRecommendBooks
  case getRecommendFromBook(id: Int)
  case postReviewByBook(id: Int, userId: Int, content: String, ratings: Int)
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
    case let .getCartByUser(id):
      return (
        path: URL(string: coreURL + "api/carts/\(id)")!,
        method: .get,
        parameter: nil,
        encoding: JSONEncoding.default
      )
    case let .postCartByUser(id, bookId):
      let params: [String: Int] = ["bookId": bookId]
      return (
        path: URL(string: coreURL + "api/carts/\(id)")!,
        method: .post,
        parameter: params,
        encoding: JSONEncoding.default
      )
    case let .getCartInfoByUser(id):
      return (
        path: URL(string: coreURL + "api/carts/\(id)/info")!,
        method: .get,
        parameter: nil,
        encoding: JSONEncoding.default
      )
    case let .postPaymentOrderByUser(id):
      return (
        path: URL(string: coreURL + "api/carts/\(id)/payment")!,
        method: .post,
        parameter: nil,
        encoding: JSONEncoding.default
      )
    case let .putQuantityOfBookByUser(id, bookId, quantity):
      let params: [String: Int] = ["quantity": quantity]
      return (
        path: URL(string: coreURL + "api/carts/\(id)/books/\(bookId)")!,
        method: .put,
        parameter: params,
        encoding: JSONEncoding.default
      )
    case .getRecommendBooks:
      return (
        path: URL(string: coreURL + "api/books/recommend")!,
        method: .get,
        parameter: nil,
        encoding: JSONEncoding.default
      )
    case let .getRecommendFromBook(id):
      return (
        path: URL(string: coreURL + "api/books/\(id)/recommend")!,
        method: .get,
        parameter: nil,
        encoding: JSONEncoding.default
      )
    case let .postReviewByBook(id, userId, content, ratings):
      let params: [String: Any] = ["userId": userId, "content": content, "ratings": ratings]
      return (
        path: URL(string: coreURL + "api/books/\(id)/reviews")!,
        method: .post,
        parameter: params,
        encoding: JSONEncoding.default
      )
    }
  }
}
