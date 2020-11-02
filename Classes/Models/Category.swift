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
        category.id = item["name"].int ?? -1
        return category
    }
}
