//
//  SearchResult.swift
//  Watcha-Task
//
//  Created by 이주혁 on 2021/02/06.
//

import Foundation

// MARK: - SearchResult
struct SearchResult: Codable {
    let data: [GIFObject]?
    let pagination: PaginationObject?
    let meta: MetaObject?
    
    enum CodingKeys: String, CodingKey {
        case data = "data"
        case pagination = "pagination"
        case meta = "meta"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = (try? values.decode([GIFObject].self, forKey: .data)) ?? nil
        pagination = (try? values.decode(PaginationObject.self, forKey: .pagination)) ?? nil
        meta = (try? values.decode(MetaObject.self, forKey: .meta)) ?? nil
    }
}
