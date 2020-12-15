//
//  DateExtension.swift
//  bsuser
//
//  Created by Khoa Le on 14/12/2020.
//

import Foundation

extension Date {
  func timeAgoDisplay() -> String {
    let formatter = RelativeDateTimeFormatter()
    formatter.unitsStyle = .full
    return formatter.localizedString(for: self, relativeTo: Date())
  }

  func getFormattedDate(format: String = "dd/MM/yyyy") -> String {
    let dateformat = DateFormatter()
    dateformat.dateFormat = format
    return dateformat.string(from: self)
  }
}

extension String {
  func getDate() -> Date? {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSXXXXX"
    dateFormatter.timeZone = TimeZone.current
    dateFormatter.locale = Locale.current
    return dateFormatter.date(from: self)
  }
}
