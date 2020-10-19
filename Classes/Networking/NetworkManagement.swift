//
//  NetworkManagement.swift
//  bsuser
//
//  Created by Khoa Le on 16/10/2020.
//

import Alamofire
import Foundation
import SwiftyJSON

enum ResponseCode: Int {
    case ok = 200
    case duplicateError = 404
    case methodFailureError = 420
    case internalServerError = 500
}

struct NetworkManagement {

    // MARK: Public

    static public func login(
        email: String,
        password: String,
        response: @escaping responseHandler
    ) {
        let requester = HTTPRequester.login(email: email, password: password)
        callAPI(requester) { code, json in
            response(code, json)
        }
    }

    static public func signup(
        username: String,
        email: String,
        password: String,
        response: @escaping responseHandler
    ) {
        let requester = HTTPRequester.signup(username: username, email: email, password: password)
        callAPI(requester) { code, json in
            response(code, json)
        }
    }

    static public func getInformationOfUserWith(
        id: Int,
        response: @escaping responseHandler
    ) {
        let requester = HTTPRequester.getInformationOfUserWith(id: id)
        callAPI(requester) { code, json in
            response(code, json)
        }
    }

    static public func getBookSearchBy(
        searchString: String,
        response: @escaping responseHandler
    ) {
        let requester = HTTPRequester.getBookSearchBy(searchString: searchString)
        callAPI(requester) { code, json in
            response(code, json)
        }
    }

    // MARK: Internal

    typealias responseHandler = (_ code: Int, _ result: JSON) -> Void

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
