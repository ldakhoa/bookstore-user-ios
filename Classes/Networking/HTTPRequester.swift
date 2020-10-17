//
//  HTTPRequester.swift
//  bsuser
//
//  Created by Khoa Le on 13/10/2020.
//

import Alamofire
import Foundation

let coreURL = "http://localhost:3000/"

protocol Requestable {
    func params() -> (
        path: URL,
        method: Alamofire.HTTPMethod,
        parameter: Parameters?,
        encoding: ParameterEncoding
    )
}

enum HTTPRequester {
    case login(email: String, password: String)
    case signup(username: String, email: String, password: String)
    case getInformationOfUserWith(id: Int)
    case updateInformationOfUserWith(id: Int)
    case getBookBySearch(searchString: String)
}

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
            let params: [String: Int] = ["id": id]
            return (
                path: URL(string: coreURL + "api/users/\(id)")!,
                method: .post,
                parameter: params,
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
        case let .getBookBySearch(searchString):
            let params: [String: String] = [:]
            return (
                path: URL(string: coreURL + "api/books/?search=\(searchString)")!,
                method: .post,
                parameter: params,
                encoding: JSONEncoding.default
            )

        }
    }
}
