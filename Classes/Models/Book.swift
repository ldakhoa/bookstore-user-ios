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
    var author: String = ""
    var title: String = ""
    var ratings: Int = -1
    var numberOfRatings: Int = -1
    var description: String = ""
    var price: Double = -1
    var discount: Double = -1
    var language: String = ""
    var publisher: String = ""
    var ISBN: String = ""
    var edition: String = ""
    var imageUrl: String = ""
    var categories = [Category]()

    // MARK: Private

    private static func parseItem(item: JSON) -> Book {
        let book = Book()
        book.id = item["id"].int ?? -1
        book.author = item["author"].string ?? ""
        book.title = item["title"].string ?? ""
        book.ratings = item["ratings"].int ?? -1
        book.price = item["price"].double ?? -1
        book.discount = item["discount"].double ?? -1
        book.language = item["language"].string ?? ""
        book.publisher = item["publisher"].string ?? ""
        book.ISBN = item["ISBN"].string ?? ""
        book.edition = item["edition"].string ?? ""
        book.imageUrl = item["imageUrl"].string ?? ""

        if let categories = item["categories"].array {
            categories.forEach { categoryItem in
                let category = Category.parseData(item: categoryItem)
                book.categories.append(category)
            }
        }
        return book
    }

}
