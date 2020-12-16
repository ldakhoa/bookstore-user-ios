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
    data.id = json["id"].string ?? ""
    data.content = json["content"].string ?? ""
    data.bookId = json["book_id"].string ?? ""
    data.updateDate = json["updated_at"].string ?? ""
    data.ratings = json["ratings"].int ?? -1

    if json["user"] != JSON.null {
      data.user = User.parseData(json: json["user"])
    }

    data.postDate = json["post_date"].string ?? ""
    data.bookTitle = json["book_title"].string ?? ""
    data.userName = json["userName"].string ?? ""
    data.userImageUrl = json["user_profile_image_url"].string ?? ""
    data.bookImageUrl = json["book_image_url"].string ?? ""
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

  var id: String? = ""
  var content: String? = ""
  var bookId: String? = ""
  var updateDate: String? = ""
  var ratings: Int? = -1
  var user: User?

  var postDate: String = ""
  var bookTitle: String = ""
  var userName: String = ""
  var userImageUrl: String = ""
  var bookImageUrl: String = ""

}
