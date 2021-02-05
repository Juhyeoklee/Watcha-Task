//
//  SearchService.swift
//  Watcha-Task
//
//  Created by 이주혁 on 2021/02/06.
//

import Foundation

import Alamofire

struct SearchService {
    static let shared = SearchService()
    
    func search(for keyword: String, limit: Int = 10, offset: Int = 0, completion: @escaping (NetworkResult<Any>) -> ()) {
        let url = APIConstants.searchURL
        
        let parameter: Parameters = [
            "api_key" : APIConstants.key,
            "q" : keyword,
            "limit" : limit,
            "offset" : offset
        ]
        
        
    }
}
