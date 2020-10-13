//
//  HTTPRequester.swift
//  bsuser
//
//  Created by Khoa Le on 13/10/2020.
//

import Foundation

let coreURL = "localhost:3000/"

enum HTTPRequester {
    case login(email: String, password: String)
    case signup(username: String, email: String, password: String)
    case logout
}
