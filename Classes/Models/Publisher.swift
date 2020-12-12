//
//  Publisher.swift
//  bsuser
//
//  Created by Khoa Le on 12/12/2020.
//

import Foundation
import SwiftyJSON

final class Publisher {
  var id: Int = -1
  var name: String = ""

  static func parseData(item: JSON) -> Publisher {
    let publisher = Publisher()
    publisher.id = item["id"].int ?? -1
    publisher.name = item["name"].string ?? ""
    return publisher
  }
}
