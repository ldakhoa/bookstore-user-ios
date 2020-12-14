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
}
