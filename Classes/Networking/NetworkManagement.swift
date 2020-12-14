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
    let requester = HTTPRequester.getCartByUser
    callAPI(requester) { code, json in
      response(code, json)
    }
  }

  public static func postCartByUser(bookId: Int, response: @escaping ResponseHandler) {
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

  public static func postPaymentOrderByUser(id: Int, response: @escaping ResponseHandler) {
    let requester = HTTPRequester.postPaymentOrderByUser(id: id)
    callAPI(requester) { code, json in
      response(code, json)
    }
  }

  public static func putQuantityOfBookByUser(
    at bookId: Int,
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

  public static func getRecommendFromBook(id: Int, response: @escaping ResponseHandler) {
    let requester = HTTPRequester.getRecommendFromBook(id: id)
    callAPI(requester) { code, json in
      response(code, json)
    }
  }

  public static func postReviewByBook(
    id: Int,
    by userId: Int,
    with content: String,
    ratings: Int,
    response: @escaping ResponseHandler
  ) {
    let requester = HTTPRequester.postReviewByBook(
      id: id,
      userId: userId,
      content: content,
      ratings: ratings
    )
    callAPI(requester) { code, json in
      response(code, json)
    }
  }

  public static func getReviewByBook(id: Int, response: @escaping ResponseHandler) {
    let requester = HTTPRequester.getReviewsByBook(id: id)
    callAPI(requester) { code, json in
      response(code, json)
    }
  }

  public static func putProfileImageUrlWithUser(
    id: Int,
    with imageUrl: String,
    response: @escaping ResponseHandler
  ) {
    let requester = HTTPRequester.putProfileImageUrlWithUser(id: id, imageUrl: imageUrl)
    callAPI(requester) { code, json in
      response(code, json)
    }
  }

  public static func uploadProfileImage(
    image: UIImage,
    response: @escaping ((_ code: Int, _ result: JSON) -> Void)
  ) {
//    let headers: HTTPHeaders = ["Content-type": "multipart/form-data", "Accept": "application/json"]
    AF.upload(
      multipartFormData: { multipartFormData in
        let imageName = NSUUID().uuidString + ".jpg"
        let avatarData = image.jpegData(compressionQuality: 0.1)!
        print("data: ", avatarData)
        print("Filename: ", imageName)
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
      headers: getHeader()
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
