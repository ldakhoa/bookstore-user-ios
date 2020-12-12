//
//  Cart.swift
//  bsuser
//
//  Created by Khoa Le on 12/12/2020.
//

import SwiftyJSON
import UIKit

final class Cart {

  // MARK: Public

  public static func parseData(json: JSON) -> Cart {
    let cart = Cart()
    cart.customerId = json["customerId"].int ?? -1
    cart.email = json["email"].string ?? ""
    cart.phone = json["phone"].int ?? -1
    cart.userName = json["user_name"].string ?? ""
    cart.address = json["address"].string ?? ""
    cart.totalPrice = json["totalPrice"].int ?? -1

    if let items = json["books"].array {
      items.forEach { item in
        let book = Book.parseItem(item: item)
        cart.books.append(book)
      }
    }

    return cart
  }

  // MARK: Internal

  var customerId: Int = -1
  var email: String = ""
  var phone: Int = -1
  var userName: String = ""
  var address: String = ""

  var books = [Book]()
  var totalPrice: Int = -1

}
