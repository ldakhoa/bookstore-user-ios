//
//  Order.swift
//  bsuser
//
//  Created by Khoa Le on 13/12/2020.
//

import Foundation
import SwiftyJSON

// MARK: - OrderStatus

enum OrderStatus: CustomStringConvertible {
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

  public static func parseData(json: JSON) -> Order {
    let data = Order()
    data.id = json["id"].string ?? ""
    data.status = json["status"].string ?? ""
    data.paymentMethod = json["payment_method"].string ?? ""
    data.totalPrice = json["total_price"].int ?? 0
    data.shippingAddress = json["shipping_address"].string ?? ""
    return data
  }

  // MARK: Internal

  var id: String = ""
  var status: String = ""
  var paymentMethod: String = ""
  var totalPrice: Int = 0
  var customerId: Int = 0
  var shippingAddress: String = ""

}
