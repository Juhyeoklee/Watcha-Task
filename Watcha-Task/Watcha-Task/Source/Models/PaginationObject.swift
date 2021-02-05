//
//  PaginationObject.swift
//  Watcha-Task
//
//  Created by 이주혁 on 2021/02/06.
//

import Foundation

// MARK: - PaginationObject
struct PaginationObject: Codable {
    let totalCount, count, offset: Int

    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case count, offset
    }
}
