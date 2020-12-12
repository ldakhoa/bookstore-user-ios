//
//  Author.swift
//  bsuser
//
//  Created by Khoa Le on 12/12/2020.
//

import Foundation
import SwiftyJSON

final class Author {
  var id: Int = -1
  var name: String = ""

  static func parseData(item: JSON) -> Author {
    let author = Author()
    author.id = item["id"].int ?? -1
    author.name = item["name"].string ?? ""
    return author
  }
}
