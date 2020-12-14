//
//  Review.swift
//  bsuser
//
//  Created by Khoa Le on 13/12/2020.
//

import Foundation
import SwiftyJSON

final class Review {

  // MARK: Public

  public static func parseData(json: JSON) -> Review {
    let data = Review()
    data.id = json["id"].int ?? 0
    data.content = json["content"].string ?? ""
    data.bookId = json["book_id"].int ?? -1
    data.updateDate = json["updated_at"].string ?? ""
    data.ratings = json["ratings"].int ?? -1

    if json["user"] != JSON.null {
      data.user = User.parseData(json: json["user"])
    }

    return data
  }

  public static func parseListOfReview(_ json: JSON) -> [Review] {
    var reviews = [Review]()
    if let arr = json["reviews"].array {
      arr.forEach { item in
        let review = Review.parseData(json: item)
        reviews.append(review)
      }
    }
    return reviews
  }

  // MARK: Internal

  var id: Int? = -1
  var content: String? = ""
  var bookId: Int? = -1
  var updateDate: String? = ""
  var ratings: Int? = -1
  var user: User?

}
