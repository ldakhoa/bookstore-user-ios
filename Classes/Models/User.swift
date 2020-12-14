//
//  User.swift
//  bsuser
//
//  Created by Khoa Le on 13/10/2020.
//

import Foundation
import SwiftyJSON

final class User {
  var id: Int = -1
  var email: String = ""
  var username: String = ""
  var password: String = ""
  var address: String = ""
  var gender: String = ""
  var phone: Int = -1
  var profileImageUrl: String = ""

  static func parseData(json: JSON) -> User {
    let user = User()
    user.id = json["id"].int ?? -1
    user.email = json["email"].string ?? ""
    user.username = json["userName"].string ?? ""
    user.password = json["password"].string ?? ""
    user.address = json["address"].string ?? ""
    user.gender = json["gender"].string ?? ""
    user.phone = json["phone"].int ?? -1
    user.profileImageUrl = json["profile_image_url"].string ?? ""
    return user
  }
}
