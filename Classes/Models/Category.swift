//
//  Category.swift
//  bsuser
//
//  Created by Khoa Le on 17/10/2020.
//

import Foundation
import SwiftyJSON

final class Category {

  // MARK: Lifecycle

  init(categoryName: String = "") {
    self.categoryName = categoryName
  }

  // MARK: Internal

  var categoryName: String = ""
  var id: Int = -1

  static func parseData(item: JSON) -> Category {
    let category = Category()
    category.categoryName = item["name"].string ?? ""
    category.id = item["id"].int ?? -1
    return category
  }

	static func parseCategories(json: JSON) -> [Category] {
		var data = [Category]()
		if let arr = json["category"].array {
			arr.forEach {
				data.append(Category.parseData(item: $0))
			}
		}
		return data
	}
}
