//
//  HTTPRequester.swift
//  bsuser
//
//  Created by Khoa Le on 13/10/2020.
//

import Alamofire
import Foundation

let coreURL = "http://192.168.1.3:3000/"

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
	case getCategories
  case getBookBy(id: String)
  case getCartByUser
  case postCartByUser(bookId: String)
  case getCartInfoByUser
  case deleteCartWithBook(id: String)
  case postPaymentOrder
  case getAllOrders
  case getOrderBy(id: String)
  case getAllOrdersBy(status: String)
  case putQuantityOfBookByUser(bookId: String, quantity: Int)
  case getRecommendBooks
  case getRecommendFromBook(id: String)
  case postReviewByBook(id: String, content: String, ratings: Int)
  case getReviewsByBook(id: String)
  case putProfileImageUrl(imageUrl: String)
	case postAddressInformation(params: [String: Any])
	case putShippingAddress(id: String)
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
    case let .getBookBy(id):
      return (
        path: URL(string: coreURL + "api/books/\(id)")!,
        method: .get,
        parameter: nil,
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
		case .getCategories:
			return (
				path: URL(string: coreURL + "api/categories")!,
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
      let params: [String: Any] = ["bookId": bookId]
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
    case let .deleteCartWithBook(id):
      return (
        path: URL(string: coreURL + "api/carts/mine/books/\(id)")!,
        method: .delete,
        parameter: nil,
        encoding: JSONEncoding.default
      )
    case .postPaymentOrder:
      return (
        path: URL(string: coreURL + "api/carts/mine/payment")!,
        method: .post,
        parameter: nil,
        encoding: JSONEncoding.default
      )
    case .getAllOrders:
      return (
        path: URL(string: coreURL + "api/orders")!,
        method: .get,
        parameter: nil,
        encoding: JSONEncoding.default
      )
    case let .getOrderBy(id):
      return (
        path: URL(string: coreURL + "api/orders/\(id)")!,
        method: .get,
        parameter: nil,
        encoding: JSONEncoding.default
      )
    case let .getAllOrdersBy(status):
      return (
        path: URL(string: coreURL + "api/orders?status=\(status)")!,
        method: .get,
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
    case let .postReviewByBook(id, content, ratings):
      let params: [String: Any] = ["content": content, "ratings": ratings]
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
		case let .postAddressInformation(params):
			return (
				path: URL(string: coreURL + "api/users/information/address")!,
				method: .post,
				parameter: params,
				encoding: JSONEncoding.default
			)
		case let .putShippingAddress(id):
			let param: [String: Any] = ["addressId": id]
			return (
				path: URL(string: coreURL + "api/carts/mine/shipping_address")!,
				method: .put,
				parameter: param,
				encoding: JSONEncoding.default
			)

    }
  }
}
