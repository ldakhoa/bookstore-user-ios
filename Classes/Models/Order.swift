//
//  Order.swift
//  bsuser
//
//  Created by Khoa Le on 13/12/2020.
//

import Foundation
import SwiftyJSON

// MARK: - OrderStatus

enum OrderStatus: String, CustomStringConvertible {
  case processing
  case delivered
  case cancelled

  var description: String {
    switch self {
    case .processing:
      return "Processing"
    case .delivered:
      return "Delivered"
    case .cancelled:
      return "Cancelled"
    }
  }
}

// MARK: - CreatedOrder

final class CreatedOrder {

  // MARK: Public

  public static func parseData(json: JSON) -> CreatedOrder {
    let data = CreatedOrder()
    if json["createdOrder"] != JSON.null {
      data.order = Order.parseData(json: json["createdOrder"])
    }
    return data
  }

  // MARK: Internal

  var order: Order?

}

// MARK: - Order

final class Order {

  // MARK: Public

  public static func parseAllOrders(json: JSON) -> [Order] {
    var orders = [Order]()
    if let arr = json["orders"].array {
      arr.forEach {
        let order = Order.parseData(json: $0)
        orders.append(order)
      }
    }
    return orders
  }

  public static func parseData(json: JSON) -> Order {
    let data = Order()
    data.id = json["id"].string ?? ""
    data.status = json["status"].string ?? ""
    data.paymentMethod = json["payment_method"].string ?? ""
    data.shippingAddress = json["shipping_address"].string ?? ""
    data.subtotal = json["sub_total_price"].double ?? 0
    data.shippingFee = json["shipping_fee"].double ?? 0
    data.totalPrice = json["total_price"].double ?? 0
    data.purchaseDate = json["purchase_date"].string ?? ""
    data.updatedDate = json["updated_at"].string ?? ""
    data.productName = json["productName"].string ?? ""
    data.booksCount = json["books_count"].int ?? 0
    data.booksQuantity = json["books_quantity"].int ?? 0

    if let bookArr = json["books"].array {
      bookArr.forEach {
        let book = Book.parseItem(item: $0)
        data.books.append(book)
      }
    }

    if json["user"] != JSON.null {
      data.user = User.parseData(json: json["user"])
    }
    return data
  }

  // MARK: Internal

  var id: String = ""
  var status: String = ""
  var paymentMethod: String = ""
  var customerId: Int = 0
  var shippingAddress: String = ""
  var subtotal: Double = 0
  var shippingFee: Double = 0
  var totalPrice: Double = 0
  var purchaseDate: String = ""
  var updatedDate: String = ""
  var productName: String = ""
  var booksCount: Int = 0
  var booksQuantity: Int = 0
  var books = [Book]()
  var user: User?

}
