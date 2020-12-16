//
//  Author.swift
//  bsuser
//
//  Created by Khoa Le on 12/12/2020.
//

import Foundation
import SwiftyJSON

final class Author {
  var id: String = ""
  var name: String = ""

  static func parseData(item: JSON) -> Author {
    let author = Author()
    author.id = item["id"].string ?? ""
    author.name = item["name"].string ?? ""
    return author
  }
}
