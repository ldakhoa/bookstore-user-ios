//
//  String+CapitalizingFirstLetter.swift
//  bsuser
//
//  Created by Khoa Le on 19/10/2020.
//

import Foundation

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }

    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}
