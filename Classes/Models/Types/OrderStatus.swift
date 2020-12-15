//
//  OrderStatus.swift
//  bsuser
//
//  Created by Khoa Le on 16/12/2020.
//

import Foundation

// MARK: - OrderStatus

enum OrderStatus: String, CustomStringConvertible {
	case processing
	case delivered
	case cancelled

	var description: String {
		switch self {
		case .processing:
			return "Processing"
		case .delivered:
			return "Delivered"
		case .cancelled:
			return "Cancelled"
		}
	}
}
