//
//  GIFObject.swift
//  Watcha-Task
//
//  Created by 이주혁 on 2021/02/06.
//

import Foundation

// MARK: - GIFObject
struct GIFObject: Codable {
    let type, id: String
    let url: String
    let slug: String
    let bitlyGIFURL, bitlyURL: String
    let embedURL: String
    let username, source, title, rating: String
    let contentURL, sourceTLD, sourcePostURL: String
    let isSticker: Int
    let importDatetime, trendingDatetime: String
    let images: Image
    let user: User
    let analyticsResponsePayload: String
    let analytics: Analytics

    enum CodingKeys: String, CodingKey {
        case type, id, url, slug
        case bitlyGIFURL = "bitly_gif_url"
        case bitlyURL = "bitly_url"
        case embedURL = "embed_url"
        case username, source, title, rating
        case contentURL = "content_url"
        case sourceTLD = "source_tld"
        case sourcePostURL = "source_post_url"
        case isSticker = "is_sticker"
        case importDatetime = "import_datetime"
        case trendingDatetime = "trending_datetime"
        case images, user
        case analyticsResponsePayload = "analytics_response_payload"
        case analytics
    }
}
