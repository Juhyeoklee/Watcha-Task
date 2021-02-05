//
//  Looping.swift
//  Watcha-Task
//
//  Created by 이주혁 on 2021/02/06.
//

import Foundation

// MARK: - Looping
struct Looping: Codable {
    let mp4Size: String
    let mp4: String

    enum CodingKeys: String, CodingKey {
        case mp4Size = "mp4_size"
        case mp4
    }
}
