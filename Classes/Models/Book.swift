//
//  Book.swift
//  bsuser
//
//  Created by Khoa Le on 13/10/2020.
//

import SwiftyJSON
import UIKit

final class Book {

  // MARK: Public

  public static func parseData(json: JSON) -> [Book] {
    var books = [Book]()
    if let bookArray = json["books"].array {
      bookArray.forEach { book in
        let book = Book.parseItem(item: book)
        books.append(book)
      }
    }
    return books
  }

  // MARK: Internal

  var id: Int = -1
  var authors = [Author]()
  var title: String = ""
  var ratings: Double = 0
  var numberOfRatings: Int = 0
  var description: String = ""
  var price: Double = 0
  var discount: Double = 0
  var language: String = ""
  var publisher: Publisher?
  var ISBN: String = ""
  var edition: String = ""
  var imageUrl: String = ""
  var categories = [Category]()

  // MARK: Private

  private static func parseItem(item: JSON) -> Book {
    let book = Book()
    book.id = item["id"].int ?? -1
    book.title = item["title"].string ?? ""
    book.ratings = item["ratings"].double ?? 0
    book.numberOfRatings = item["numberOfRatings"].int ?? 0
    book.price = item["price"].double ?? 0
    book.discount = item["discount"].double ?? 0
    book.language = item["language"].string ?? ""
    book.ISBN = item["ISBN"].string ?? ""
    book.edition = item["edition"].string ?? ""
    book.imageUrl = item["imageUrl"].string ?? ""

		if item["publisher"] != JSON.null {
			book.publisher = Publisher.parseData(item: item["publisher"])
		}
		
    if let categories = item["categories"].array {
      categories.forEach { categoryItem in
        let category = Category.parseData(item: categoryItem)
        book.categories.append(category)
      }
    }

		if let authors = item["authors"].array {
			authors.forEach { authorItem in
				let author = Author.parseData(item: authorItem)
				book.authors.append(author)
			}
		}
    return book
  }
}
