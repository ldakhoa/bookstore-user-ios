//
//  Cart.swift
//  bsuser
//
//  Created by Khoa Le on 12/12/2020.
//

import SwiftyJSON
import UIKit

// MARK: - Cart

final class Cart {

  // MARK: Public

  public static func parseData(json: JSON) -> Cart {
    let cart = Cart()
    cart.customerId = json["customerId"].int ?? -1
    cart.email = json["email"].string ?? ""
    cart.phone = json["phone"].int ?? -1
    cart.userName = json["user_name"].string ?? ""
    cart.shippingFee = json["shipping_fee"].double ?? 0
    cart.subtotalPrice = json["sub_total_price"].double ?? 0
    cart.totalPrice = json["total_price"].double ?? 0
    cart.shippingAddressId = json["shipping_address_id"].int ?? 0
    cart.contactPhoneNumber = json["contact_phone_number"].string ?? "+84"
    cart.shippingAddress = json["shipping_address"].string ?? ""

    if let items = json["books"].array {
      items.forEach { item in
        let book = Book.parseItem(item: item)
        cart.books.append(book)
      }
    }

    if let items = json["addresses"].array {
      items.forEach { item in
        let address = Address.parseData(json: item)
        cart.addresses.append(address)
      }
    }

    return cart
  }

  // MARK: Internal

  var customerId: Int = -1
  var email: String = ""
  var phone: Int = -1
  var userName: String = ""
  var books = [Book]()
  var shippingFee: Double = 0
  var totalPrice: Double = 0
  var subtotalPrice: Double = 0
  var addresses = [Address]()
  var shippingAddressId: Int = 0
  var contactPhoneNumber: String = ""
  var shippingAddress: String = ""
}

// MARK: - CartInfo

final class CartInfo {

  // MARK: Public

  public static func parseData(json: JSON) -> CartInfo {
    let data = CartInfo()
    data.booksCount = json["books_count"].int ?? 0
    data.booksQuantity = json["books_quantity"].int ?? 0
    data.totalPrice = json["total_price"].double ?? 0
    data.subtotalPrice = json["sub_total_price"].double ?? 0
    data.shippingFee = json["shipping_fee"].double ?? 0
    return data
  }

  // MARK: Internal

  var booksCount: Int = 0
  var booksQuantity: Int = 0
  var subtotalPrice: Double = 0
  var shippingFee: Double = 0
  var totalPrice: Double = 0

}
