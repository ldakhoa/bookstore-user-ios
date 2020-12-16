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

  public static func getInformationOfUser(response: @escaping ResponseHandler) {
    let requester = HTTPRequester.getInformationOfUser
    callAPI(requester) { code, json in
      response(code, json)
    }
  }

  public static func updateInformationOfUserWith(
    params: [String: Any],
    response: @escaping ResponseHandler
  ) {
    let requester = HTTPRequester.updateInformationOfUserWith(param: params)
    callAPI(requester) { code, json in
      response(code, json)
    }
  }

  public static func getBookBy(
    id: String,
    response: @escaping ResponseHandler
  ) {
    let requester = HTTPRequester.getBookBy(id: id)
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

  public static func getBookByCategory(
    _ category: String,
    response: @escaping ResponseHandler
  ) {
    let requester = HTTPRequester.getBookByCategory(category: category)
    callAPI(requester) { code, json in
      response(code, json)
    }
  }

  public static func getCategories(response: @escaping ResponseHandler) {
    let requester = HTTPRequester.getCategories
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

  public static func getCartByUser(response: @escaping ResponseHandler) {
    let requester = HTTPRequester.getCartByUser
    callAPI(requester) { code, json in
      response(code, json)
    }
  }

  public static func postCartByUser(bookId: String, response: @escaping ResponseHandler) {
    let requester = HTTPRequester.postCartByUser(bookId: bookId)
    callAPI(requester) { code, json in
      response(code, json)
    }
  }

  public static func getCartInfoByUser(response: @escaping ResponseHandler) {
    let requester = HTTPRequester.getCartInfoByUser
    callAPI(requester) { code, json in
      response(code, json)
    }
  }

  public static func deleteCartWithBook(id: String, response: @escaping ResponseHandler) {
    let requester = HTTPRequester.deleteCartWithBook(id: id)
    callAPI(requester) { code, json in
      response(code, json)
    }
  }

  public static func postPaymentOrder(with params: [String: Any],response: @escaping ResponseHandler) {
    let requester = HTTPRequester.postPaymentOrder(params: params)
    callAPI(requester) { code, json in
      response(code, json)
    }
  }

  public static func getAllOrdersByStatus(_ status: String, response: @escaping ResponseHandler) {
    let requester = HTTPRequester.getAllOrdersBy(status: status)
    callAPI(requester) { code, json in
      response(code, json)
    }
  }

  public static func getAllOrders(response: @escaping ResponseHandler) {
    let requester = HTTPRequester.getAllOrders
    callAPI(requester) { code, json in
      response(code, json)
    }
  }

  public static func getOrderBy(id: String, response: @escaping ResponseHandler) {
    let requester = HTTPRequester.getOrderBy(id: id)
    callAPI(requester) { code, json in
      response(code, json)
    }
  }

  public static func putQuantityOfBookByUser(
    at bookId: String,
    quantity: Int,
    response: @escaping ResponseHandler
  ) {
    let requester = HTTPRequester.putQuantityOfBookByUser(bookId: bookId, quantity: quantity)
    callAPI(requester) { code, json in
      response(code, json)
    }
  }

  public static func getRecommendBooks(response: @escaping ResponseHandler) {
    let requester = HTTPRequester.getRecommendBooks
    callAPI(requester) { code, json in
      response(code, json)
    }
  }

  public static func getRecommendFromBook(id: String, response: @escaping ResponseHandler) {
    let requester = HTTPRequester.getRecommendFromBook(id: id)
    callAPI(requester) { code, json in
      response(code, json)
    }
  }

  public static func postReviewByBook(
    id: String,
    with content: String,
    ratings: Int,
    response: @escaping ResponseHandler
  ) {
    let requester = HTTPRequester.postReviewByBook(
      id: id,
      content: content,
      ratings: ratings
    )
    callAPI(requester) { code, json in
      response(code, json)
    }
  }

  public static func getReviewByBook(id: String, response: @escaping ResponseHandler) {
    let requester = HTTPRequester.getReviewsByBook(id: id)
    callAPI(requester) { code, json in
      response(code, json)
    }
  }

  public static func getAllReviews(response: @escaping ResponseHandler) {
    let requester = HTTPRequester.getAllReviews
    callAPI(requester) { code, json in
      response(code, json)
    }
  }

  public static func putProfileImageUrl(
    _ imageUrl: String,
    response: @escaping ResponseHandler
  ) {
    let requester = HTTPRequester.putProfileImageUrl(imageUrl: imageUrl)
    callAPI(requester) { code, json in
      response(code, json)
    }
  }

  public static func uploadProfileImage(
    image: UIImage,
    response: @escaping ((_ code: Int, _ result: JSON) -> Void)
  ) {
//    let headers: HTTPHeaders = ["Content-type": "multipart/form-data", "Accept": "application/json"]
    var header: HTTPHeaders = [
      "content-type": "multipart/form-data",
      "Accept": "application/json",
    ]
    if AppSecurity.shared.token.isEmpty == false {
      header["authorization"] = "Bearer " + AppSecurity.shared.token
    }

    AF.upload(
      multipartFormData: { multipartFormData in
        let imageName = NSUUID().uuidString + ".jpg"
        let avatarData = image.jpegData(compressionQuality: 0.1)!
        multipartFormData.append(
          avatarData,
          withName: "filetoupload",
          fileName: imageName,
          mimeType: "image/jpeg"
        )
      },
      to: URL(string: coreURL + "api/images/profile_image")!,
      usingThreshold: UInt64.init(),
      method: .post,
      headers: header
    ).responseJSON { responseData in
      switch responseData.result {
      case .success(_):
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

  public static func postAddressInformation(
    with params: [String: Any],
    response: @escaping ResponseHandler
  ) {
    let requester = HTTPRequester.postAddressInformation(params: params)
    callAPI(requester) { code, json in
      response(code, json)
    }
  }

  public static func putShippingAddress(with addressId: String, response: @escaping ResponseHandler) {
    let requester = HTTPRequester.putShippingAddress(id: addressId)
    callAPI(requester) { code, json in
      response(code, json)
    }
  }

  public static func deleteShippingAddress(at id: String, response: @escaping ResponseHandler) {
    let requester = HTTPRequester.deleteShippingAddress(id: id)
    callAPI(requester) { code, json in
      response(code, json)
    }
  }

  public static func getShippingAddress(at id: String, response: @escaping ResponseHandler) {
    let requester = HTTPRequester.getShippingAddress(id: id)
    callAPI(requester) { code, json in
      response(code, json)
    }
  }

  public static func putShippingAddress(
    at id: String,
    params: [String: Any],
    response: @escaping ResponseHandler
  ) {
    let requester = HTTPRequester.putShippingAddressWithParams(id: id, params: params)
    callAPI(requester) { code, json in
      response(code, json)
    }
  }

  public static func postFavorBookWithBookId(_ id: String, response: @escaping ResponseHandler) {
    let requester = HTTPRequester.postFavorBookWithBookId(id: id)
    callAPI(requester) { code, json in
      response(code, json)
    }
  }

  public static func getAllFavorBooks(response: @escaping ResponseHandler) {
    let requester = HTTPRequester.getAllFavorBooks
    callAPI(requester) { code, json in
      response(code, json)
    }
  }

  public static func deleteFavorBookWithBookId(_ id: String, response: @escaping ResponseHandler) {
    let requester = HTTPRequester.deleteFavorBookWithBookId(id: id)
    callAPI(requester) { code, json in
      response(code, json)
    }
  }

  // MARK: Internal

  typealias ResponseHandler = (_ code: Int, _ result: JSON) -> Void

  // MARK: Private

  private static func getHeader() -> HTTPHeaders {
    var header: HTTPHeaders = [
      "content-type": "application/json",
      "Accept": "application/json",
    ]
    if AppSecurity.shared.token.isEmpty == false {
      header["authorization"] = "Bearer " + AppSecurity.shared.token
    }

    return header
  }

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
      encoding: request.params().encoding,
      headers: getHeader()
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

        if let token = parseJSON["token"].string {
          AppSecurity.shared.token = token
        }
        response(responseCode, parseJSON)
      case .failure:
        response(ResponseCode.internalServerError.rawValue, JSON.null)
      }
    }
  }
}
