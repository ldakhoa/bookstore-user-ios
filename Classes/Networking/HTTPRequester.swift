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
  case getInformationOfUser
  case updateInformationOfUserWith(param: [String: Any])
  case getBookSearchBy(searchString: String)
  case getBookSearchWithFilterBy(searchString: String, filterType: FilterType)
  case getBookByCategory(category: String)
  case getCartByUser
  case postCartByUser(bookId: Int)
  case getCartInfoByUser
  case postPaymentOrderByUser(id: Int)
  case putQuantityOfBookByUser(bookId: Int, quantity: Int)
  case getRecommendBooks
  case getRecommendFromBook(id: Int)
  case postReviewByBook(id: Int, userId: Int, content: String, ratings: Int)
  case getReviewsByBook(id: Int)
  case putProfileImageUrl(imageUrl: String)
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
        path: URL(string: coreURL + "api/auth")!,
        method: .post,
        parameter: params,
        encoding: JSONEncoding.default
      )
    case .getInformationOfUser:
      return (
        path: URL(string: coreURL + "api/users/information")!,
        method: .get,
        parameter: nil,
        encoding: JSONEncoding.default
      )
    case let .updateInformationOfUserWith(params):
      return (
        path: URL(string: coreURL + "api/users/information")!,
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
    case let .getBookByCategory(category):
      return (
        path: URL(string: coreURL + "api/books/?category=\(category)&filter=category&limit=20")!,
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
    case .getCartByUser:
      return (
        path: URL(string: coreURL + "api/carts/mine")!,
        method: .get,
        parameter: nil,
        encoding: JSONEncoding.default
      )
    case let .postCartByUser(bookId):
      let params: [String: Int] = ["bookId": bookId]
      return (
        path: URL(string: coreURL + "api/carts/mine")!,
        method: .post,
        parameter: params,
        encoding: JSONEncoding.default
      )
    case .getCartInfoByUser:
      return (
        path: URL(string: coreURL + "api/carts/mine/info")!,
        method: .get,
        parameter: nil,
        encoding: JSONEncoding.default
      )
    case .postPaymentOrderByUser:
      return (
        path: URL(string: coreURL + "api/carts/mine/payment")!,
        method: .post,
        parameter: nil,
        encoding: JSONEncoding.default
      )
    case let .putQuantityOfBookByUser(bookId, quantity):
      let params: [String: Int] = ["quantity": quantity]
      return (
        path: URL(string: coreURL + "api/carts/mine/books/\(bookId)")!,
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
    case let .getReviewsByBook(id):
      return (
        path: URL(string: coreURL + "api/books/\(id)/reviews")!,
        method: .get,
        parameter: nil,
        encoding: JSONEncoding.default
      )
    case let .putProfileImageUrl(imageUrl):
      let params: [String: String] = ["profile_image_url": imageUrl]
      return (
        path: URL(string: coreURL + "api/users/information")!,
        method: .put,
        parameter: params,
        encoding: JSONEncoding.default
      )
    }
  }
}
