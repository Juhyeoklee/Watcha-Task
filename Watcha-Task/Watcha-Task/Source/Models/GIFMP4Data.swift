//
//  GIFMP4Data.swift
//  Watcha-Task
//
//  Created by 이주혁 on 2021/02/06.
//

import Foundation

// MARK: - GIFMP4Data
struct GIFMP4Data: Codable {
    let height, width, mp4Size: String
    let mp4: String

    enum CodingKeys: String, CodingKey {
        case height, width
        case mp4Size = "mp4_size"
        case mp4
    }
}
