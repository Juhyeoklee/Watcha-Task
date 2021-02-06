//
//  GIFGenericData.swift
//  Watcha-Task
//
//  Created by 이주혁 on 2021/02/06.
//

import Foundation






// MARK: - GIFGenericData
struct GIFGenericData: Codable {
    let height, width, size: String
    let url: String
    let mp4Size: String
    let mp4: String
    let webpSize: String
    let webp: String
    let frames, hash: String

    enum CodingKeys: String, CodingKey {
        case height, width, size, url
        case mp4Size = "mp4_size"
        case mp4
        case webpSize = "webp_size"
        case webp, frames, hash
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        height = (try? values.decode(String.self, forKey: .height)) ?? ""
        width = (try? values.decode(String.self, forKey: .width)) ?? ""
        size = (try? values.decode(String.self, forKey: .size)) ?? ""
        url = (try? values.decode(String.self, forKey: .url)) ?? ""
        mp4Size = (try? values.decode(String.self, forKey: .mp4Size)) ?? ""
        mp4 = (try? values.decode(String.self, forKey: .mp4)) ?? ""
        webpSize = (try? values.decode(String.self, forKey: .webpSize)) ?? ""
        webp = (try? values.decode(String.self, forKey: .webp)) ?? ""
        frames = (try? values.decode(String.self, forKey: .frames)) ?? ""
        hash = (try? values.decode(String.self, forKey: .hash)) ?? ""
    }
}
