//
//  NetworkManagement.swift
//  bsuser
//
//  Created by Khoa Le on 16/10/2020.
//

import Alamofire
import Foundation
import JGProgressHUD
import SwiftyJSON

// MARK: - ResponseCode

enum ResponseCode: Int {
  case ok = 200
  case duplicateError = 404
  case methodFailureError = 420
  case internalServerError = 500
}

// MARK: - NetworkManagement

struct NetworkManagement {

  // MARK: Public

  public static func login(
    email: String,
    password: String,
    response: @escaping ResponseHandler
  ) {
    let requester = HTTPRequester.login(email: email, password: password)
    callAPI(requester) { code, json in
      response(code, json)
    }
  }

  public static func signup(
    username: String,
    email: String,
    password: String,
    response: @escaping ResponseHandler
  ) {
    let requester = HTTPRequester.signup(username: username, email: email, password: password)
    callAPI(requester) { code, json in
      response(code, json)
    }
  }

  public static func getInformationOfUserWith(
    id: Int,
    response: @escaping ResponseHandler
  ) {
    let requester = HTTPRequester.getInformationOfUserWith(id: id)
    callAPI(requester) { code, json in
      response(code, json)
    }
  }

  public static func getBookSearchBy(
    searchString: String,
    response: @escaping ResponseHandler
  ) {
    let requester = HTTPRequester.getBookSearchBy(searchString: searchString)
    callAPI(requester) { code, json in
      response(code, json)
    }
  }

  public static func getBookSearchWithFilterBy(
    searchString: String,
    filterType: FilterType,
    response: @escaping ResponseHandler
  ) {
    let requester = HTTPRequester.getBookSearchWithFilterBy(
      searchString: searchString,
      filterType: filterType
    )
    callAPI(requester) { code, json in
      response(code, json)
    }
  }

  public static func getCartByUser(id: Int, response: @escaping ResponseHandler) {
    let requester = HTTPRequester.getCartByUser(id: id)
    callAPI(requester) { code, json in
      response(code, json)
    }
  }

  public static func postCartByUser(id: Int, bookId: Int, response: @escaping ResponseHandler) {
    let requester = HTTPRequester.postCartByUser(id: id, bookId: bookId)
    callAPI(requester) { code, json in
      response(code, json)
    }
  }

  public static func getCartInfoByUser(id: Int, response: @escaping ResponseHandler) {
    let requester = HTTPRequester.getCartInfoByUser(id: id)
    callAPI(requester) { code, json in
      response(code, json)
    }
  }

  public static func postPaymentOrderByUser(id: Int, response: @escaping ResponseHandler) {
    let requester = HTTPRequester.postPaymentOrderByUser(id: id)
    callAPI(requester) { code, json in
      response(code, json)
    }
  }

  public static func putQuantityOfBookByUser(
    id: Int,
    at bookId: Int,
    quantity: Int,
    response: @escaping ResponseHandler
  ) {
    let requester = HTTPRequester.putQuantityOfBookByUser(id: id, bookId: bookId, quantity: quantity)
    callAPI(requester) { code, json in
      response(code, json)
    }
  }

  // MARK: Internal

  typealias ResponseHandler = (_ code: Int, _ result: JSON) -> Void

  // MARK: Private

  private static func callAPI(
    _ request: HTTPRequester,
    response: @escaping ((_ code: Int, _ result: JSON) -> Void)
  ) {
    let manager = Alamofire.Session.default
    manager.session.configuration.timeoutIntervalForRequest = 15
    manager.request(
      request.params().path,
      method: request.params().method,
      parameters: request.params().parameter,
      encoding: request.params().encoding
    ).responseJSON { responseData in
      switch responseData.result {
      case .success:
        guard let data = responseData.data,
              let parseJSON = try? JSON(data: data) else { return }
        var responseCode = ResponseCode.ok.rawValue
        if let code = parseJSON["code"].int {
          Log.debug("Response code: ", code)
          responseCode = code
        }
        response(responseCode, parseJSON)
      case .failure:
        response(ResponseCode.internalServerError.rawValue, JSON.null)
      }
    }
  }
}
