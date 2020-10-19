//
//  Book.swift
//  bsuser
//
//  Created by Khoa Le on 13/10/2020.
//

import UIKit
import SwiftyJSON

final class Book {
    let id: Int = -1
    let author: String = ""
    let title: String = ""
    let ratings: Int = -1
    let numberOfRatings: Int = -1
    let description: String = ""
    let price: Int = -1
    let discount: Int = -1
    let language: String = ""
    let publisher: String = ""
    let ISBN: String = ""
    let edition: String = ""
    let imageUrl: String = ""
    let categories = [Category]()

    static func parseData(json: JSON) {
        
    }
}
