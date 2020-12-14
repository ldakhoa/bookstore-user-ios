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
  var gender: String = ""
  var phone: Int = -1
  var profileImageUrl: String = ""
  var address: String? = ""
  var district: String? = ""
  var ward: String? = ""
  var zipCode: Int? = 700000
  var country: String? = "Vietnam"
  var city: String? = ""
  var birthDate: String? = ""

  static func parseData(json: JSON) -> User {
    let user = User()
    user.id = json["id"].int ?? -1
    user.email = json["email"].string ?? ""
    user.username = json["userName"].string ?? ""
    user.password = json["password"].string ?? ""
    user.gender = json["gender"].string ?? ""
    user.phone = json["phone"].int ?? -1
    user.profileImageUrl = json["profile_image_url"].string ?? ""
    user.address = json["address"].string ?? ""
    user.district = json["district"].string ?? ""
    user.ward = json["ward"].string ?? ""
    user.zipCode = json["zipCode"].int ?? 700000
    user.country = json["country"].string ?? "Vietnam"
    user.city = json["city"].string ?? ""
    user.birthDate = json["birthDate"].string ?? ""
    return user
  }
}
