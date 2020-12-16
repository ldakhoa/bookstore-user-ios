//
//  User.swift
//  bsuser
//
//  Created by Khoa Le on 13/10/2020.
//

import Foundation
import SwiftyJSON

// MARK: - User

final class User {
  var id: String = ""
  var email: String = ""
  var username: String = ""
  var password: String = ""
  var gender: String = ""
  var phone: Int = 84
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
    user.id = json["id"].string ?? ""
    user.email = json["email"].string ?? ""
    user.username = json["userName"].string ?? ""
    user.password = json["password"].string ?? ""
    user.gender = json["gender"].string ?? ""
    user.phone = json["phone"].int ?? 84
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

// MARK: - Address

final class Address {
  var id: String? = ""
  var name: String? = ""
  //	var userPhone: String
  //	var userName: String
  var city: String? = ""
  var district: String? = ""
  var ward: Int? = 0
  var zipCode: Int? = 700000
  var country: String? = "Vietnam"
  var userId: Int? = 0

  static func parseData(json: JSON) -> Address {
    let data = Address()
    data.id = json["id"].string ?? ""
    data.name = json["name"].string ?? ""
    data.city = json["city"].string ?? ""
    data.ward = json["ward"].int ?? 0
    data.zipCode = json["zip_code"].int ?? 700000
    data.country = json["country"].string ?? "Vietnam"
    return data
  }

}
