//
//  Log.swift
//  bsuser
//
//  Created by Khoa Le on 16/10/2020.
//

import Foundation
import Log

let Log = Logger()

func logError(
    _ items: Any...,
    separator: String = " ",
    terminator: String = "\n",
    file: String = #file,
    line: Int = #line,
    column: Int = #column,
    function: String = #function
) {
    Log.error(
        items,
        separator: separator,
        terminator: terminator,
        file: file,
        line: line,
        column: column,
        function: function
    )
}

func logDebug(
    _ items: Any...,
    separator: String = " ",
    terminator: String = "\n",
    file: String = #file,
    line: Int = #line,
    column: Int = #column,
    function: String = #function
) {
    Log.debug(
        items,
        separator: separator,
        terminator: terminator,
        file: file,
        line: line,
        column: column,
        function: function
    )
}
